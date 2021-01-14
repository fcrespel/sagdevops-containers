#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export CC_WAIT=180

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e TES --wait-for-cc

    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.TES

    echo "Verifying instances ..."
    sagcc get inventory components -e TES-default

    echo "Start the instance ..."
    sagcc exec lifecycle components TES-default start -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus TES-default -e ONLINE
fi

echo "Verifying product runtime ..."
curl -sf http://localhost:9510/config

if [ -d $SAG_HOME/profiles/SPM ] ; then
    echo "Shut down the instance ..."
    sagcc exec lifecycle components TES-default stop -e DONE --sync-job
fi

echo "DONE testing"
