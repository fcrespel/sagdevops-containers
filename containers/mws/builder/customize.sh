#!/bin/sh -e

# MySQL Connector/J version
MYSQL_CJ_VERSION="8.0.23"

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm
    export CC_WAIT=180
    export __mws_instance_name=${__mws_instance_name:-default}

    echo "Shut down the instance ..."
    sagcc exec lifecycle components "OSGI-MWS_${__mws_instance_name}" stop -e DONE --sync-job
fi

# Download MySQL Connector/J
curl -sSLf --retry 5 "https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CJ_VERSION}/mysql-connector-java-${MYSQL_CJ_VERSION}.jar" -o "$SAG_HOME/common/lib/ext/mysql-connector-java.jar"
ln -s "../../common/lib/ext/mysql-connector-java.jar" "$SAG_HOME/MWS/lib/mysql-connector-java.jar"

# Create OSGi bundle for MWS
cat - > "$SAG_HOME/MWS/lib/mysql-connector-java.bnd" <<EOF
# attach as fragment to the caf.server bundle
Fragment-Host: com.webmethods.caf.server
Bundle-SymbolicName: mysql-connector-java-
Bundle-Version: ${MYSQL_CJ_VERSION}
Include-Resource: mysql-connector-java.jar
-exportcontents: *
Bundle-ClassPath: mysql-connector-java.jar
Import-Package: *;resolution:=optional
EOF

# Clean OSGi profile and update instance
echo "osgi.clean=true" >> "$SAG_HOME/profiles/MWS_default/configuration/config.ini"
$SAG_HOME/MWS/bin/mws.sh update
