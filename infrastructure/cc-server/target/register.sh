#!/bin/sh

export SAG_HOME=${SAG_HOME:-/opt/softwareag}
export CC_CLI_HOME=${CC_CLI_HOME:-$SAG_HOME/CommandCentral/client}
export CC_PASSWORD=${CC_PASSWORD:-manage}
export CC_SERVER=${CC_SERVER:-cc}
export CC_AUTO_REGISTER=${CC_AUTO_REGISTER:-0} # no registration by default

if [ -f $SAG_HOME/profiles/SPM/bin/startup.sh ]; then
    # start SPM in the background
    $SAG_HOME/profiles/SPM/bin/startup.sh

    # self-register alias
    ALIAS=${CC_NODE_ALIAS:-`hostname`}

    if [[ "$CC_AUTO_REGISTER" -eq 1 && ! "$CC_SERVER" == "localhost" && -f $CC_CLI_HOME/bin/sagcc ]]; then
        echo "Registering '$ALIAS' with Command Central server '$CC_SERVER' ..."
        $CC_CLI_HOME/bin/sagcc list landscape nodes --wait-for-cc
        $CC_CLI_HOME/bin/sagcc add landscape nodes alias=$ALIAS url="https://`hostname`:8093" description="Auto registered docker node" -e OK -w 180 -c 20
        $CC_CLI_HOME/bin/sagcc list landscape nodes
    else
        echo "SKIP: Registration of '$ALIAS' with Command Central server '$CC_SERVER'"
    fi

else
    echo "WARNING: management agent (SPM) is not found"
fi
