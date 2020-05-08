#!/bin/sh

echo "Cleaning up $SAG_HOME ..."
cd $SAG_HOME

echo 'Disk usage before cleaning:'
du -h -d 2

echo "Removing Update Manager but keep metadata (SAGUpdateManager/UpdateManager/profile/p2) ..."
cd SAGUpdateManager && rm -rf bin jvm logs osgi && \
cd UpdateManager && rm -rf bootstrap conf logs readme repository workdata restart_script && \
cd profile && rm -rf *.xml *.ini configuration plugins && \
cd $SAG_HOME

echo "Removing Installer but keep install/products metadata ..."
rm -fr install/repo install/logs install/jars install/bpms install/etc install/fix/backup install/fix/profile/org.eclipse.equinox.p2.core/cache
rm -f sagProducts.xml sagMetadata.xml p2.index

echo "Removing Licenses and doc ..."
#rm -fr Licenses/
rm -fr _documentation/

echo "Removing log files ..."
rm -f `find ./ -name *.log`

# echo "Removing Common ..."
# rm -rf common/db/
# rm -rf common/runtime/install/
# rm -rf common/runtime/agent/

echo "Removing Java ..."
rm -fr jvm/

echo 'Disk usage after cleaning:'
du -h -d 2
