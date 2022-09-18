#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update license
if [ -n "$LICENSE_BASE64" ]; then
    echo "Updating license ..."
    echo "$LICENSE_BASE64" | base64 -d > "$SAG_HOME/Broker/license.xml"
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

# Create Broker server
if [ ! -e "$BROKER_DATA_DIR/awbroker.cfg" ]; then
    mkdir -p "$BROKER_DATA_DIR"
    $SAG_HOME/Broker/bin/server_config create "$BROKER_DATA_DIR" -p 6849 -k "$SAG_HOME/Broker/license.xml" -nostart \
        -session_config qs -qs_log_file "$BROKER_DATA_DIR/BrokerConfig.qs.log" "$BROKER_CONFIG_LOG_SIZE" -qs_storage_file "$BROKER_DATA_DIR/BrokerConfig.qs.stor" "$BROKER_CONFIG_SIZE" "$BROKER_DEFAULT_RESERVED_SIZE" \
        -session_data qs -qs_log_file "$BROKER_DATA_DIR/BrokerData.qs.log" "$BROKER_DATA_LOG_SIZE" -qs_storage_file "$BROKER_DATA_DIR/BrokerData.qs.stor" "$BROKER_DATA_SIZE" "$BROKER_DEFAULT_RESERVED_SIZE"
    if [ $? -ne 0 ]; then
        echo "Failed to create new Broker server"
        exit 1
    fi
else
    echo "Adding existing Broker server ..."
    $SAG_HOME/Broker/bin/server_config add "$BROKER_DATA_DIR" -p 6849 -k "$SAG_HOME/Broker/license.xml"
    if [ $? -ne 0 ]; then
        echo "Failed to add existing Broker server"
        exit 1
    fi
fi

# Update configuration
if [ -n "$BROKER_CONFIG_PARAMS" ]; then
    echo "Setting session config params: $BROKER_CONFIG_PARAMS"
    sed -ri "s#(/BrokerConfig.*\\.qs).*#\\1?$BROKER_CONFIG_PARAMS#g" "$BROKER_DATA_DIR/awbroker.cfg"
fi
if [ -n "$BROKER_DATA_PARAMS" ]; then
    echo "Setting session data params: $BROKER_DATA_PARAMS"
    sed -ri "s#(/BrokerData.*\\.qs).*#\\1?$BROKER_DATA_PARAMS#g" "$BROKER_DATA_DIR/awbroker.cfg"
fi
if [ -n "$BROKER_SERVER_PARAMS" ]; then
    while IFS='=' read k v; do
        if [ -n "$k" -a -n "$v" ]; then
            if grep -q "^$k=" "$BROKER_DATA_DIR/awbroker.cfg"; then
                echo "Setting server config param: $k=$v"
                sed -ri "s#^$k=.*#$k=$v#g" "$BROKER_DATA_DIR/awbroker.cfg"
            else
                echo "Adding server config param: $k=$v"
                echo "$k=$v" >> "$BROKER_DATA_DIR/awbroker.cfg"
            fi
        fi
    done <<< "${BROKER_SERVER_PARAMS// /$'\n'}"
fi

# Configure shutdown handler
trap "$SAG_HOME/Broker/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/Broker/bin/startup.sh
echo "Waiting for Broker server to start ..."
RETRY=20
while [ $RETRY -gt 0 ]; do
    sleep 3
    $SAG_HOME/Broker/bin/broker_status && break
    RETRY=$((RETRY-1))
done
if [ $RETRY -eq 0 ]; then
    echo "Broker failed to start"
    exit 1
fi

# Create Broker
echo "Creating Broker ${BROKER_NAME} ..."
$SAG_HOME/Broker/bin/broker_create "${BROKER_NAME:-default}" -default

# Create JNDI objects
echo "Creating JNDI objects ..."
BROKER_HOSTNAME=${BROKER_HOSTNAME:-$(hostname -f)}
BROKER_HOSTNAME_INTERNAL=${BROKER_HOSTNAME_INTERNAL:-$(hostname -f)}
BROKER_PORT=${BROKER_PORT:-6849}
BROKER_PORT_INTERNAL=${BROKER_PORT_INTERNAL:-6849}
sed -e "s#{{BROKER_NAME}}#${BROKER_NAME}#g" \
    -e "s#{{BROKER_HOSTNAME_INTERNAL}}#${BROKER_HOSTNAME_INTERNAL}#g" \
    -e "s#{{BROKER_PORT_INTERNAL}}#${BROKER_PORT_INTERNAL}#g" \
    "jmsadmin.properties" > "jmsadmin.properties.tmp"
sed -e "s#{{BROKER_NAME}}#${BROKER_NAME}#g" \
    -e "s#{{BROKER_CLIENTGROUP}}#${BROKER_CLIENTGROUP}#g" \
    -e "s#{{BROKER_HOSTNAME}}#${BROKER_HOSTNAME}#g" \
    -e "s#{{BROKER_HOSTNAME_INTERNAL}}#${BROKER_HOSTNAME_INTERNAL}#g" \
    -e "s#{{BROKER_PORT}}#${BROKER_PORT}#g" \
    -e "s#{{BROKER_PORT_INTERNAL}}#${BROKER_PORT_INTERNAL}#g" \
    "jmsadmin.script" > "jmsadmin.script.tmp"
$SAG_HOME/Broker/bin/jmsadmin -p "jmsadmin.properties.tmp" -f "jmsadmin.script.tmp"
rm -f "jmsadmin.properties.tmp" "jmsadmin.script.tmp"

# Show logs
echo "Broker server started"
tail -f "$BROKER_DATA_DIR/logmsgs" &

# Wait for shutdown
PID=$!
wait $PID
