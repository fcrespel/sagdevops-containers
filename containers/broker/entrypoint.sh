#!/bin/sh

if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

$SAG_HOME/Broker/bin/startup.sh

echo "Waiting for Broker server to start ..."
while ! $SAG_HOME/Broker/bin/broker_status; do
    sleep 1
done

echo "Broker server started"
trap "$SAG_HOME/Broker/bin/shutdown.sh" SIGINT SIGTERM EXIT
tail -f "$SAG_HOME/Broker/data/default/logmsgs"
