### Asset Build Environment (ABE) image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Provision, unit test, cleanup
RUN $CC_HOME/provision.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh

# Target image
FROM $BASE_IMAGE

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Environment variables
ENV ABE_HOME=$SAG_HOME/common/AssetBuildEnvironment
ENV CC_CLI_HOME=$SAG_HOME/CommandCentral/client
ENV PATH=$PATH:$ABE_HOME/bin:$CC_CLI_HOME/bin

# Switch to source directory
WORKDIR /src

# Main command
CMD build.sh
