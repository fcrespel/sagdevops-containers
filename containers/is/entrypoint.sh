#!/bin/sh

if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

exec $SAG_HOME/profiles/IS_*/bin/console.sh
