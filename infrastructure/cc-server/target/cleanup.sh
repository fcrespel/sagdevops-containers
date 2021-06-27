#!/bin/sh

CLEANUP_MODE="${1:-full}"

echo "Cleaning up $SAG_HOME (mode=$CLEANUP_MODE)..."
cd $SAG_HOME

echo "Disk usage before cleaning:"
du -h -d 2

echo "Shutting down CCE/SPM ..."
[ ! -e $CC_HOME/profiles/CCE ] || $CC_HOME/profiles/CCE/bin/shutdown.sh
[ ! -e $CC_HOME/profiles/SPM ] || $CC_HOME/profiles/SPM/bin/shutdown.sh
[ ! -e $SAG_HOME/profiles/SPM ] || $SAG_HOME/profiles/SPM/bin/shutdown.sh

echo "Removing installer logs/backups/cache ..."
rm -fr install/logs install/fix/backup install/fix/profile/org.eclipse.equinox.p2.core/cache
rm -f sagProducts.xml sagMetadata.xml p2.index

echo "Removing Licenses and doc ..."
rm -fr Licenses/ _documentation/

echo "Removing log files ..."
rm -f `find ./ -name *.log`
rm -fr cc-boot/

if [ "$CLEANUP_MODE" = "full" ]; then
    echo "Removing Update Manager ..."
    rm -fr SAGUpdateManager

    echo "Removing Java ..."
    rm -fr jvm/
else
    echo "Removing Java backup ..."
    rm -fr jvm/*.bck
fi

echo "Disk usage after cleaning:"
du -h -d 2
