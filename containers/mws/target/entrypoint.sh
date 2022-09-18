#!/bin/bash

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Create or migrate database schema
if [ "$MWS_DB_TYPE" != "internal" ]; then
    $SAG_HOME/common/db/bin/dbConfigurator.sh -a create -d "${MWS_DB_TYPE//mysql*/mysql}" -pr MywebMethodsServer -l "$MWS_DB_URL" -u "$MWS_DB_USERNAME" -p "$MWS_DB_PASSWORD" -n "$MWS_DB_NAME"
    $SAG_HOME/common/db/bin/dbConfigurator.sh -a migrate -d "${MWS_DB_TYPE//mysql*/mysql}" -pr MywebMethodsServer -l "$MWS_DB_URL" -u "$MWS_DB_USERNAME" -p "$MWS_DB_PASSWORD" -n "$MWS_DB_NAME"
    $SAG_HOME/MWS/bin/mws.sh ant -f $SAG_HOME/MWS/server/deploy.xml -e check-db-params update-mws-db-xml -Ddb.type="$MWS_DB_TYPE" -Ddb.url="$MWS_DB_URL" -Ddb.username="$MWS_DB_USERNAME" -Ddb.password="$MWS_DB_PASSWORD"
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/profiles/MWS_default/configuration/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/profiles/MWS_default/configuration/custom_wrapper.conf

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

# Process environment variables
echo "Processing environment variables ..."
while IFS='=' read -r k v; do
    if [ -n "$v" ]; then
        if [[ "$k" =~ ^MWS_USER_PWD_.* ]]; then
            # User password
            USERNAME="${k//MWS_USER_PWD_/}"
            echo "- Updating password for user $USERNAME"
            echo "<CONTEXT alias=\"system.directory.user.storage\"><wm_xt_sysdiruser name=\"$USERNAME\" password=\"$v\" /></CONTEXT>" > "$SAG_HOME/MWS/server/default/deploy/user_$USERNAME.xml"
        fi
    fi
done < <(env | sort)

# Configure shutdown handler
trap "$SAG_HOME/profiles/MWS_default/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/MWS_default/bin/console.sh "$@" &

# Wait for shutdown
PID=$!
wait $PID
