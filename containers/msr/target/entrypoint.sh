#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Configure shutdown handler
trap "$SAG_HOME/IntegrationServer/bin/shutdown.sh" SIGINT SIGTERM

# Start server
rm -f "$SAG_HOME/IntegrationServer/bin/.lock"
$SAG_HOME/IntegrationServer/bin/server.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
