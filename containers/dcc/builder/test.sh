#!/bin/sh -e

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e DatabaseComponentConfigurator --wait-for-cc

    echo "Verifying fixes ..."
    sagcc get inventory fixes -e wMFix.DatabaseComponentConfigurator
fi

echo "DONE testing"
