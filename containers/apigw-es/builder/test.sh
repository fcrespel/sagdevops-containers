#!/bin/sh -e

# workaround for missing path in scripts
sed -i "s#sh el_initd#sh $SAG_HOME/InternalDataStore/bin/el_initd#g" "$SAG_HOME/InternalDataStore/bin/startup.sh" "$SAG_HOME/InternalDataStore/bin/restart.sh" "$SAG_HOME/InternalDataStore/bin/shutdown.sh"

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e CEL --wait-for-cc
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.CEL || true

    echo "Verifying instances ..."
    sagcc get inventory components -e CEL

    echo "Start the instance ..."
    # sagcc exec lifecycle components CEL start -e DONE --sync-job
    $SAG_HOME/InternalDataStore/bin/startup.sh

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus CEL -e ONLINE
fi

echo "Verifying product runtime ..."
curl -sf -u Administrator:manage http://`hostname`:9240/

if [ -d $SAG_HOME/profiles/SPM ] ; then
    echo "Shut down the instance ..."
    # sagcc exec lifecycle components CEL stop -e DONE --sync-job
    $SAG_HOME/InternalDataStore/bin/shutdown.sh
fi

echo "DONE testing"
