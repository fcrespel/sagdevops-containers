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

# Expose ports
EXPOSE 8090 8091 8092 8093 8992 8993

# Automatically add arguments and files when using this image for build
ONBUILD ARG REPO_USERNAME=""
ONBUILD ARG REPO_PASSWORD="" 
ONBUILD ARG REPO_PRODUCT_URL=""
ONBUILD ARG REPO_PRODUCT_NAME="products"
ONBUILD ARG REPO_FIX_URL="https://sdc.softwareag.com/updates/prodRepo"
ONBUILD ARG REPO_FIX_NAME="fixes"
ONBUILD ARG LICENSES_URL=""
ONBUILD ADD --chown=1724:1724 builder/ $CC_HOME/
