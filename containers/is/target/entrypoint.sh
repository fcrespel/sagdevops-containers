#!/bin/sh

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/profiles/IS_default/configuration/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/profiles/IS_default/configuration/custom_wrapper.conf

# Configure shutdown handler
trap "$SAG_HOME/profiles/IS_default/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/IS_default/bin/console.sh -log both "$@" &

# Wait for shutdown
PID=$!
wait $PID
