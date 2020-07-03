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

echo "Start the instance ..."
$SAG_HOME/IntegrationServer/bin/startup.sh

echo "Verifying product runtime ..."
RETRY=20
while [ $RETRY -gt 0 ] && ! curl -sf http://`hostname`:5555/invoke/wm.server/ping; do
    sleep 3
    RETRY=$((RETRY-1))
done
curl -sf http://`hostname`:5555/invoke/wm.server/ping

echo "Shut down the instance ..."
$SAG_HOME/IntegrationServer/bin/shutdown.sh

echo "DONE testing"
