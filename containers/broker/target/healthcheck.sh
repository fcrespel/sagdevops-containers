#!/bin/sh

$SAG_HOME/Broker/bin/broker_ping "${BROKER_NAME:-default}@localhost:6849" -timeout 10
RET=$?
if [ $RET -eq 115 ]; then
    # Ignore Pause Publishing
    RET=0
fi
exit $RET
