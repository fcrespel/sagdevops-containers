#!/bin/sh

if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

exec $UM_HOME/server/$UM_REALM/bin/nserverdaemon console
