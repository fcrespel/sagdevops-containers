#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Configure shutdown handler
trap "$SAG_HOME/profiles/IS_default/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/IS_default/bin/console.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
