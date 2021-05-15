### API Gateway Kibana image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 9405

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/profiles/IS_apigateway/apigateway/dashboard/ $SAG_HOME/kibana/

# Add overlay from target directory
ADD --chown=1724:1724 target/ $SAG_HOME/

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=5 CMD [ "/opt/softwareag/healthcheck.sh" ]

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
