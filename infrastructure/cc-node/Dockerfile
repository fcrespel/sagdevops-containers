### Command Central node image

# Build arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Builder image
FROM $BUILDER_IMAGE as builder

# Installer arguments
ARG CC_INSTALLER
ARG CC_INSTALLER_URL="https://empowersdc.softwareag.com/ccinstallers"
ARG REPO_USERNAME=""
ARG REPO_PASSWORD="" 
ARG REPO_PRODUCT_URL=""
ARG REPO_PRODUCT_NAME="products"
ARG REPO_FIX_URL="https://sdc.softwareag.com/updates/prodRepo"
ARG REPO_FIX_NAME="fixes"

# Provision managed node with SPM and install latest fixes
RUN $CC_HOME/provision.sh sag-update && $CC_HOME/cleanup.sh light

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 8092 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Environment variables
ENV CC_SERVER="cc" \
    CC_PASSWORD="manage" \
    CC_AUTO_REGISTER="0" \
    CC_CLI_HOME="$SAG_HOME/CommandCentral/client" \
    JAVA_HOME="$SAG_HOME/jvm/jvm"
ENV PATH="$PATH:$CC_CLI_HOME/bin:$JAVA_HOME/bin"

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
