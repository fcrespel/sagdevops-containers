#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export CC_WAIT=180

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e MSC --wait-for-cc

    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.integrationServer.Core
fi

#echo "Verifying product runtime ..."
#curl -sf http://`hostname`:5555/invoke/wm.server/ping

echo "DONE testing"
