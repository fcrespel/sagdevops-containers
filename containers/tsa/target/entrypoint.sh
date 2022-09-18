#!/bin/bash

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/Terracotta/server/wrapper/conf/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/Terracotta/server/wrapper/conf/custom_wrapper.conf

# Update license
if [ -n "$LICENSE_BASE64" ]; then
    echo "Updating license ..."
    echo "$LICENSE_BASE64" | base64 -d > "$SAG_HOME/Terracotta/terracotta-license.key"
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

# Update current node name
if [ -n "$TC_NODE_NAME" ]; then
    echo "Setting current node name: $TC_NODE_NAME"
    sed -i "s#=node\$#=$TC_NODE_NAME#g" $SAG_HOME/Terracotta/server/wrapper/conf/custom_wrapper.conf
    TC_NODES="${TC_NODES:-$TC_NODE_NAME}"
fi

# Update nodes list
if [ -n "$TC_NODES" ]; then
    echo "Setting nodes list: $TC_NODES"
    xsltproc --stringparam nodes "$TC_NODES" update-tc-config.xsl "$SAG_HOME/Terracotta/server/wrapper/conf/tc-config.xml" > tc-config.xml.tmp
    mv -f tc-config.xml.tmp "$SAG_HOME/Terracotta/server/wrapper/conf/tc-config.xml"
fi

# Configure shutdown handler
trap "$SAG_HOME/Terracotta/server/wrapper/bin/tsa-service stop" SIGINT SIGTERM

# Start server
$SAG_HOME/Terracotta/server/wrapper/bin/tsa-service console "$@" &

# Wait for shutdown
PID=$!
wait $PID
