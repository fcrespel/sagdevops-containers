### Command Central server image

# Build arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Installer arguments
ARG CC_INSTALLER
ARG CC_INSTALLER_URL="https://empowersdc.softwareag.com/ccinstallers"

# Environment variables
ENV CC_HOME="/opt/sagtools" \
    CC_SERVER="localhost" \
    CC_PASSWORD="manage" \
    CC_CLI_HOME="/opt/sagtools/CommandCentral/client" \
    ANT_HOME="/opt/sagtools/common/lib/ant" \
    JAVA_HOME="/opt/sagtools/jvm/jvm/jre" \
    JRE_HOME="/opt/sagtools/jvm/jvm/jre"
ENV PATH="$PATH:$CC_CLI_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin"

# Add overlay from target directory
ADD --chown=1724:1724 target/ $CC_HOME/

# Switch to Command Central directory
WORKDIR $CC_HOME

# Install Command Central + SPM
RUN export NODES=local SAG_HOME=$CC_HOME && \
    $CC_HOME/bootstrap.sh && $CC_HOME/provision.sh && $CC_HOME/cleanup.sh light

# Expose ports
EXPOSE 8090 8091 8992 8993

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=5 CMD [ "/opt/sagtools/healthcheck.sh" ]

# Entrypoint script
CMD ["/bin/sh", "-c", "$CC_HOME/cce-entrypoint.sh"]
