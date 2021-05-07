#!/bin/bash

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Create or migrate database schema
if [ "$MWS_DB_TYPE" != "internal" ]; then
    $SAG_HOME/common/db/bin/dbConfigurator.sh -a create -d "${MWS_DB_TYPE//mysql*/mysql}" -pr MywebMethodsServer -l "$MWS_DB_URL" -u "$MWS_DB_USERNAME" -p "$MWS_DB_PASSWORD" -n "$MWS_DB_NAME"
    $SAG_HOME/common/db/bin/dbConfigurator.sh -a migrate -d "${MWS_DB_TYPE//mysql*/mysql}" -pr MywebMethodsServer -l "$MWS_DB_URL" -u "$MWS_DB_USERNAME" -p "$MWS_DB_PASSWORD" -n "$MWS_DB_NAME"
    $SAG_HOME/MWS/bin/mws.sh ant -f $SAG_HOME/MWS/server/deploy.xml -e update-mws-db-xml -Ddb.type="$MWS_DB_TYPE" -Ddb.url="$MWS_DB_URL" -Ddb.username="$MWS_DB_USERNAME" -Ddb.password="$MWS_DB_PASSWORD"
fi

# Update config
[ -n "$JAVA_MIN_MEM" ] && sed -i "s#^wrapper.java.initmemory=.*\$#wrapper.java.initmemory=$JAVA_MIN_MEM#g" $SAG_HOME/profiles/MWS_default/configuration/custom_wrapper.conf
[ -n "$JAVA_MAX_MEM" ] && sed -i "s#^wrapper.java.maxmemory=.*\$#wrapper.java.maxmemory=$JAVA_MAX_MEM#g" $SAG_HOME/profiles/MWS_default/configuration/custom_wrapper.conf

# Configure shutdown handler
trap "$SAG_HOME/profiles/MWS_default/bin/shutdown.sh" SIGINT SIGTERM

# Start server
$SAG_HOME/profiles/MWS_default/bin/console.sh "$@" &

# Wait for shutdown
PID=$!
wait $PID
