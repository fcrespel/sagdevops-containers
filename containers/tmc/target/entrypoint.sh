#!/bin/bash

# Update config
if [ -n "$TSA_URL" -a -e "$SAG_HOME/.tc/mgmt/server/tc_no_security_ctxt.xml" ]; then
    sed -i "s#@TSA_URL@#$TSA_URL#g" "$SAG_HOME/.tc/mgmt/server/tc_no_security_ctxt.xml"
fi

# Configure shutdown handler
trap "$SAG_HOME/Terracotta/tools/management-console/bin/stop-tmc.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/Terracotta/tools/management-console/bin/start-tmc.sh "$@" &

# Wait for shutdown
PID=$!
wait $PID
