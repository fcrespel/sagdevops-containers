#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Configure shutdown handler
trap "$UM_HOME/server/$UM_REALM/bin/nstopserver" SIGINT SIGTERM

# Start server
exec $UM_HOME/server/$UM_REALM/bin/nserverdaemon console "$@" &

# Wait for shutdown
PID=$!
wait $PID
