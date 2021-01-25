#!/bin/sh
set -e

sagcc_installer="${CC_INSTALLER}.sh"

# download at least once
if [ ! -f $sagcc_installer ]; then
    curl -k -L -u Administrator:manage -o $CC_HOME/$sagcc_installer "${CC_INSTALLER_URL}/${sagcc_installer}"
    chmod +x $CC_HOME/$sagcc_installer
fi

# SPM is on non-default ports
sh $CC_HOME/$sagcc_installer --accept-license -D CCE -d $CC_HOME -H localhost -c 8090 -C 8091 -s 8992 -S 8993 -p $CC_PASSWORD

# boot cleanup
rm -rf $CC_HOME/$sagcc_installer $CC_HOME/profiles/CCE/data/installers/* /tmp/* || true
