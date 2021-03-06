### Microservices Runtime image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Provision, unit test, cleanup
RUN $CC_HOME/provision.sh && $CC_HOME/customize.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh && \
    sed -i "s#$(hostname)#localhost#g" $SAG_HOME/IntegrationServer/config/remote.cnf && \
    rm -Rf $SAG_HOME/profiles/CTP

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 5555 9999 9192 8092 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Add overlay from target directory
ADD --chown=1724:1724 target/ $SAG_HOME/

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=5 CMD [ "/opt/softwareag/healthcheck.sh" ]

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
