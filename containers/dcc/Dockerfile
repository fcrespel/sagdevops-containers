### Database Component Configurator (DCC) image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Build arguments
ARG MYSQL_CJ_VERSION="8.0.23"

# Download MySQL JDBC driver
RUN curl -sSLf --retry 5 "https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CJ_VERSION}/mysql-connector-java-${MYSQL_CJ_VERSION}.jar" -o "$SAG_HOME/common/lib/ext/mysql-connector-java.jar"

# Provision, unit test, cleanup
RUN $CC_HOME/provision.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh

# Target image
FROM $BASE_IMAGE

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/common/db/bin/dbConfigurator.sh"]
