#!/bin/sh -e

function downloadFileFromURL() {
    local urlPath="$1"
    local destination="$2"
    if curl -sSLf --retry 5 "$urlPath" -o "$destination/$(basename $urlPath)"; then
         echo "- Successfully downloaded $(basename $urlPath)"
         return 0
    else
         echo "! Error while downloading $urlPath"
         return 1
    fi
}

function downloadFromMavenCentral() {
    local urlPath="$1"
    local destination="$2"
    downloadFileFromURL "https://repo1.maven.org/maven2/$urlPath" "$destination"
}

function downloadFromConfluent() {
    local urlPath="$1"
    local destination="$2"
    downloadFileFromURL "https://packages.confluent.io/maven/$urlPath" "$destination"
}

IS_HOME="$SAG_HOME/IntegrationServer"

echo "Installing JDBC JARs ..."
IS_CUSTOM_JARS="$IS_HOME/lib/jars/custom"
mkdir -p "$IS_CUSTOM_JARS"
downloadFromMavenCentral "com/ingres/jdbc/iijdbc/10.2-4.1.10/iijdbc-10.2-4.1.10.jar" "$IS_CUSTOM_JARS"
downloadFromMavenCentral "com/microsoft/sqlserver/mssql-jdbc/9.2.1.jre15/mssql-jdbc-9.2.1.jre15.jar" "$IS_CUSTOM_JARS"
downloadFromMavenCentral "com/oracle/ojdbc/ojdbc8/19.3.0.0/ojdbc8-19.3.0.0.jar" "$IS_CUSTOM_JARS"
downloadFromMavenCentral "mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar" "$IS_CUSTOM_JARS"
downloadFromMavenCentral "org/postgresql/postgresql/42.2.19/postgresql-42.2.19.jar" "$IS_CUSTOM_JARS"

echo "Installing Kafka JARs ..."
KAFKA_JARS="$IS_HOME/packages/WmKafkaAdapter/code/jars/static"
mkdir -p "$KAFKA_JARS"
downloadFromMavenCentral "com/github/luben/zstd-jni/1.4.4-7/zstd-jni-1.4.4-7.jar" "$KAFKA_JARS"
downloadFromMavenCentral "com/sun/jersey/jersey-client/1.16/jersey-client-1.16.jar" "$KAFKA_JARS"
downloadFromMavenCentral "com/sun/jersey/jersey-server/1.16/jersey-server-1.16.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/apache/avro/avro/1.9.2/avro-1.9.2.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/apache/commons/commons-compress/1.19/commons-compress-1.19.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/apache/kafka/kafka_2.13/2.6.0/kafka_2.13-2.6.0.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/apache/kafka/kafka-clients/2.6.0/kafka-clients-2.6.0.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/apache/kafka/kafka-tools/2.6.0/kafka-tools-2.6.0.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/lz4/lz4-java/1.7.1/lz4-java-1.7.1.jar" "$KAFKA_JARS"
downloadFromMavenCentral "org/xerial/snappy/snappy-java/1.1.7.3/snappy-java-1.1.7.3.jar" "$KAFKA_JARS"
downloadFromConfluent "io/confluent/common-utils/6.0.0/common-utils-6.0.0.jar" "$KAFKA_JARS"
downloadFromConfluent "io/confluent/kafka-avro-serializer/6.0.0/kafka-avro-serializer-6.0.0.jar" "$KAFKA_JARS"
downloadFromConfluent "io/confluent/kafka-schema-registry-client/6.0.0/kafka-schema-registry-client-6.0.0.jar" "$KAFKA_JARS"
downloadFromConfluent "io/confluent/kafka-schema-serializer/6.0.0/kafka-schema-serializer-6.0.0.jar" "$KAFKA_JARS"
