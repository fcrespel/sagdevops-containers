#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $UM_HOME/server/$UM_REALM/bin/Custom_Server_Common.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $UM_HOME/server/$UM_REALM/bin/Custom_Server_Common.conf

# Configure shutdown handler
trap "$UM_HOME/server/$UM_REALM/bin/nstopserver" SIGINT SIGTERM

# Start server
$UM_HOME/server/$UM_REALM/bin/nserverdaemon console "$@" &

# Wait for shutdown
PID=$!
wait $PID
