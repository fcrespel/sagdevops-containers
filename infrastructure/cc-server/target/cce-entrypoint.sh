#!/bin/sh

#strap SIGTERM signal

_term() {
 echo "Caught SIGTERM signal!"
 echo "stopping SPM"
  $CC_HOME/profiles/SPM/bin/shutdown.sh
 echo "stopping CCE"
  $CC_HOME/profiles/CCE/bin/shutdown.sh
 exit 0
}

trap _term SIGTERM


# change Administrator password
if [ ! -z "$CC_PASSWORD" ]; then
    echo "Changing Administrator password ..."
    $CC_HOME/common/bin/internaluserrepo.sh -f $CC_HOME/profiles/CCE/configuration/security/users.txt -p "$CC_PASSWORD" Administrator
fi

# ???? why?
rm ~/.sag/cc.properties

echo "Remove old logs"
rm -rf $CC_HOME/profiles/SPM/logs/*.log
rm -rf $CC_HOME/profiles/CCE/logs/*.log

# launch in the background to allow restarts during fix installation!!!
$CC_HOME/profiles/SPM/bin/startup.sh
echo "Waiting for SPM HTTP stack ..."
until curl -s http://`hostname`:8992/
do
    sleep 5
done
echo "SPM is ONLINE"

$CC_HOME/profiles/CCE/bin/startup.sh

echo "CCE and SPM processes started. Waiting for services ..."
# wait until default.log comes up
while [  ! -f $CC_HOME/profiles/CCE/logs/default.log ]; do
    tail $CC_HOME/profiles/CCE/logs/wrapper.log
    sleep 10
done

echo "Waiting for Command Central HTTP stack ..."
until curl -s http://`hostname`:8090/ 
do 
    sleep 5
done

echo "Command Central is ONLINE"

echo "Executing $CC_HOME/init.sh ..."

if $CC_HOME/init.sh ; then
    echo ""
    echo "INITIALIZATION SUCCESSFUL"
    echo ""
    $CC_HOME/inventory.sh
else
    echo ""
    echo "ERROR: INITIALIZATION FAILED! Stopping container ..."
    echo ""
    exit 100
fi

echo "Command Central is READY"

# this is our main container process
tail -f $CC_HOME/profiles/CCE/logs/default.log &
wait $!
