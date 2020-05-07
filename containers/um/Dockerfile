### Universal Messaging Realm server image

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
EXPOSE 9000 8082 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Environment variables
ENV UM_HOME=$SAG_HOME/UniversalMessaging
ENV UM_INSTANCE_NAME=${__um_instance_name:-default}
ENV UM_REALM=${__um_realm:-default}

# Entrypoint script
ADD --chown=1724:1724 entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
