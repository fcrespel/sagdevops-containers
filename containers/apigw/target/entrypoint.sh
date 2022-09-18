#!/bin/sh

# Variables
IS_HOME="$SAG_HOME/IntegrationServer"
IS_INSTANCE="$IS_HOME/instances/apigateway"

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/profiles/IS_apigateway/configuration/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/profiles/IS_apigateway/configuration/custom_wrapper.conf

# Update license
if [ -n "$LICENSE_BASE64" ]; then
    echo "Updating license ..."
    echo "$LICENSE_BASE64" | base64 -d > "$IS_INSTANCE/config/licenseKey.xml"
fi

# Process environment variables
java -cp $IS_INSTANCE/packages/WmAPIGateway/bin/lib/apigateway-tools.jar com.softwareag.apigateway.tools.docker.ModifyExternalProperties apigateway

# Configure shutdown handler
trap "$SAG_HOME/profiles/IS_apigateway/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/IS_apigateway/bin/console.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
