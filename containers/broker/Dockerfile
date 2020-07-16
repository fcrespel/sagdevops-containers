### Broker Server image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Provision, unit test, cleanup
RUN $CC_HOME/provision.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 6849 6850 8092 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Add overlay from target directory
ADD --chown=1724:1724 target/* $SAG_HOME/

# Environment variables
ENV BROKER_DATA_DIR="$SAG_HOME/Broker/data" \
    BROKER_CONFIG_SIZE="1G" \
    BROKER_CONFIG_PARAMS="" \
    BROKER_DATA_SIZE="4G" \
    BROKER_DATA_PARAMS="async,max_cache_size=512" \
    BROKER_SERVER_PARAMS="max-memory-size=1024 max-recv-events=400" \
    BROKER_NAME="default"

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
