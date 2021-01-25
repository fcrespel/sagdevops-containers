### Command Central builder image

# Build arguments
ARG BASE_IMAGE
ARG NODE_IMAGE

# Source image
FROM $NODE_IMAGE as node

# Target image
FROM $BASE_IMAGE

# Provisioning arguments
ARG REPO_USERNAME=""
ARG REPO_PASSWORD="" 
ARG REPO_PRODUCT_URL=""
ARG REPO_PRODUCT_NAME="products"
ARG REPO_FIX_URL="https://sdc.softwareag.com/updates/prodRepo"
ARG REPO_FIX_NAME="fixes"
ARG LICENSES_URL=""

# Copy install directory from node image
COPY --from=node --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Add overlay from target directory
ADD --chown=1724:1724 target/ $CC_HOME/

# Configure repos and licenses
RUN $CC_HOME/provision.sh

# Environment variables
ENV __install_dir=$SAG_HOME

# Automatically add files when using this image for build
ONBUILD ADD --chown=1724:1724 builder/* $CC_HOME/
