#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Process environment variables
java -cp $SAG_HOME/IntegrationServer/instances/apigateway/packages/WmAPIGateway/bin/lib/apigateway-tools.jar com.softwareag.apigateway.tools.docker.ModifyExternalProperties apigateway

# Configure shutdown handler
trap "$SAG_HOME/profiles/IS_apigateway/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/IS_apigateway/bin/console.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
