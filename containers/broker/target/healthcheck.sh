#!/bin/sh

$SAG_HOME/Broker/bin/broker_ping "${BROKER_NAME:-default}@localhost:6849" -timeout 10
