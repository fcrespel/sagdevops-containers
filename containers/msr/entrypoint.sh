#!/bin/sh

if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

exec $SAG_HOME/IntegrationServer/bin/console.sh
