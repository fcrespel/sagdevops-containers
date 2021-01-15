### Sample image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Build-time template parameter: hello.name
ARG __hello_name=default

# Provision, unit test, cleanup
RUN $CC_HOME/provision.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 8092 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Add overlay from target directory
ADD --chown=1724:1724 target/ $SAG_HOME/

# Run-time container init parameter
ENV HELLO_NAME=default

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
