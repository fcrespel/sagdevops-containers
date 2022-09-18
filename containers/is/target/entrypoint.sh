#!/bin/bash

# Variables
IS_HOME="$SAG_HOME/IntegrationServer"
IS_INSTANCE="$IS_HOME/instances/default"

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/profiles/IS_default/configuration/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/profiles/IS_default/configuration/custom_wrapper.conf

# Copy packages
if [ "$SYNC_PACKAGES" != "false" -a "$SYNC_PACKAGES" != "0" ]; then
    echo "Syncing packages ..."
    for PKG in $IS_HOME/packages/*/; do
        echo "- $(basename $PKG)"
        rsync -a --delete "$IS_HOME/packages/$(basename $PKG)" "$IS_INSTANCE/packages/"
    done
fi

# Copy config
if [ "$SYNC_CONFIG" != "false" -a "$SYNC_CONFIG" != "0" ]; then
    RSYNC_EXCLUDES=""
    if [ -n "$SYNC_CONFIG_EXCLUDE" ]; then
        for RSYNC_EXCLUDE in ${SYNC_CONFIG_EXCLUDE//,/ }; do
            RSYNC_EXCLUDES="$RSYNC_EXCLUDES --exclude $RSYNC_EXCLUDE"
        done
    fi
    echo "Syncing config ..."
    eval rsync -a $RSYNC_EXCLUDES --delete "$IS_HOME/config/" "$IS_INSTANCE/config/"
fi

# Update license
if [ -n "$LICENSE_BASE64" ]; then
    echo "Updating license ..."
    echo "$LICENSE_BASE64" | base64 -d > "$IS_INSTANCE/config/licenseKey.xml"
fi

# Update timezone
if [ -n "$TIMEZONE" ]; then
    echo "Configuring timezone ($TIMEZONE) ..."
    if [ -e "/usr/share/zoneinfo/$TIMEZONE" ]; then
        cp "/usr/share/zoneinfo/$TIMEZONE" "/etc/localtime"
        echo "Timezone updated: $(date)"
    else
        echo "Unable to find timezone $TIMEZONE at /usr/share/zoneinfo/$TIMEZONE"
        exit 1
    fi
fi

# Update loadbalancer host/port
echo "Updating web service provider endpoints ..."
xsltproc --stringparam host "${WS_HTTP_LB_HOST:-$(hostname -f)}" --stringparam port "${WS_HTTP_LB_PORT:-5555}" update-endpoint.xsl "$IS_INSTANCE/config/endpoints/providerHTTP.cnf" > "$IS_INSTANCE/config/endpoints/providerHTTP.cnf.tmp" && mv -f "$IS_INSTANCE/config/endpoints/providerHTTP.cnf.tmp" "$IS_INSTANCE/config/endpoints/providerHTTP.cnf"
xsltproc --stringparam host "${WS_HTTPS_LB_HOST:-$(hostname -f)}" --stringparam port "${WS_HTTPS_LB_PORT:-6555}" update-endpoint.xsl "$IS_INSTANCE/config/endpoints/providerHTTPS.cnf" > "$IS_INSTANCE/config/endpoints/providerHTTPS.cnf.tmp" && mv -f "$IS_INSTANCE/config/endpoints/providerHTTPS.cnf.tmp" "$IS_INSTANCE/config/endpoints/providerHTTPS.cnf"

# Process environment variables
echo "Processing environment variables ..."
while IFS='=' read -r k v; do
    if [ -n "$v" ]; then
        if [[ "$k" =~ ^IS_USER_PWD_.* ]]; then
            # User password
            USERNAME="${k//IS_USER_PWD_/}"
            echo "- Updating password for user $USERNAME"
            sed "s#{{USERNAME}}#$USERNAME#g" update-pwd.xsl > update-pwd.xsl.tmp
            xsltproc --stringparam password "$v" update-pwd.xsl.tmp "$IS_INSTANCE/config/users.cnf" > "$IS_INSTANCE/config/users.cnf.tmp"
            mv -f "$IS_INSTANCE/config/users.cnf.tmp" "$IS_INSTANCE/config/users.cnf"
            rm -f update-pwd.xsl.tmp
        elif [[ "$k" =~ ^IS_JNDI_URL_.* ]]; then
            # JNDI alias
            JNDI_NAME="${k//IS_JNDI_URL_/}"
            if [ -e "$IS_INSTANCE/config/jndi/jndi_${JNDI_NAME}.properties" ]; then
                echo "- Updating JNDI alias $JNDI_NAME"
                sed -i "s#^java.naming.provider.url=.*\$#java.naming.provider.url=${v//:/\\:}#g" "$IS_INSTANCE/config/jndi/jndi_${JNDI_NAME}.properties"
            fi
        elif [[ "$k" =~ ^IS_DBFUNCTION_POOL_.* ]]; then
            # DBFunction
            DBFUNCTION="${k//IS_DBFUNCTION_POOL_/}"
            echo "- Updating pool of function: $DBFUNCTION"
            if [ -e "$IS_INSTANCE/config/jdbc/function/${DBFUNCTION}.xml" ]; then
                xsltproc --stringparam poolAlias "$v" update-dbfunction-pool.xsl "$IS_INSTANCE/config/jdbc/function/${DBFUNCTION}.xml" > "$IS_INSTANCE/config/jdbc/function/${DBFUNCTION}.xml.tmp"
                mv -f "$IS_INSTANCE/config/jdbc/function/${DBFUNCTION}.xml.tmp" "$IS_INSTANCE/config/jdbc/function/${DBFUNCTION}.xml"
            fi
        elif [[ "$k" =~ ^IS_JDBCPOOL_.* ]]; then
            # JDBC Pool
            JDBC_POOL_PARAMETER=$(echo "$k" | cut -d "_" -f3)
            JDBC_POOL_NAME=$(echo "$k" | cut -d "_" -f4)
            if [ -e "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml" ]; then
                echo "- Updating $JDBC_POOL_PARAMETER of JDBC Pool alias $JDBC_POOL_NAME"
                if [[ "$JDBC_POOL_PARAMETER" == "URL" ]]; then
                    JDBC_POOL_PARAMETER="dbURL"
                    JDBC_POOL_VALUE="$v"
                elif [[ "$JDBC_POOL_PARAMETER" == "USER" ]]; then
                    JDBC_POOL_PARAMETER="userid"
                    JDBC_POOL_VALUE="$v"
                elif [[ "$JDBC_POOL_PARAMETER" == "PWD" ]]; then
                    # Double encoding for byte
                    JDBC_POOL_VALUE=$(echo -n "$v" | base64 -w0 | base64 -w0)
                    xsltproc --stringparam pwd "$JDBC_POOL_VALUE" update-jdbcpool-pwd.xsl "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml" > "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml.tmp"
                    mv -f "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml.tmp" "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml"
                    continue
                else
                  echo "- Unknown parameter $JDBC_POOL_PARAMETER in variable $k"
                  exit 1
                fi
                sed "s#{{KEY}}#$JDBC_POOL_PARAMETER#g" update-jdbcpool.xsl > update-jdbcpool.xsl.tmp
                xsltproc --stringparam value "$JDBC_POOL_VALUE" update-jdbcpool.xsl.tmp "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml" > "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml.tmp"
                mv -f "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml.tmp" "$IS_INSTANCE/config/jdbc/pool/${JDBC_POOL_NAME,,}.xml"
                rm -f update-jdbcpool.xsl.tmp
            fi
        elif [[ "$k" =~ ^watt\..* ]]; then
            # Extended Settings
            if grep -q "^$k=" "$IS_INSTANCE/config/server.cnf"; then
                echo "- Updating Extended Setting: $k=$v"
                sed -ri "s#^$k=.*#$k=$v#g" "$IS_INSTANCE/config/server.cnf"
            else
                echo "- Adding Extended Setting: $k=$v"
                echo "$k=$v" >> "$IS_INSTANCE/config/server.cnf"
            fi
        fi
    fi
done < <(env | sort)

# Configure shutdown handler
trap "$SAG_HOME/profiles/IS_default/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/IS_default/bin/console.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
