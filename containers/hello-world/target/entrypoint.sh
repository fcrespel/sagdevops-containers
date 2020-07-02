#!/bin/sh -e

echo "Hello $HELLO_NAME !"

if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

exec $SAG_HOME/profiles/SPM/bin/console.sh
