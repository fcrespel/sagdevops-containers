### Command Central builder image

# Build arguments
ARG BUILDER_IMAGE
ARG NODE_IMAGE

# Source image
FROM $NODE_IMAGE as node

# Target image
FROM $BUILDER_IMAGE

# Switch to Command Central directory
WORKDIR $CC_HOME

# Copy install directory from node image
COPY --from=node --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Configure repos, add licenses and apply initial updates
ADD --chown=1724:1724 . $CC_HOME
RUN mv $SAG_HOME/jvm/jvm $SAG_HOME/jvm/jvm_tmp && \
    mv $SAG_HOME/jvm/jvm_tmp $SAG_HOME/jvm/jvm && \
    $CC_HOME/provision.sh && \
    rm -Rf $SAG_HOME/jvm/*.bck && \
    rm -f $SAG_HOME/jvm/jvm/src.zip

# Automatically add files when using this image for build
ONBUILD ADD --chown=1724:1724 . $CC_HOME
