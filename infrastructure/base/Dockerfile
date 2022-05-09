### OS image for all SoftwareAG products

# Build arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Install packages and updates
RUN yum -y update &&\
    yum -y install epel-release file gettext iproute less libxslt net-tools rsync sysvinit-tools unzip which &&\
    yum -y install jq &&\
    yum -y clean all

# Set install directory and locale
ENV SAG_HOME=/opt/softwareag \
    WM_HOME=/opt/softwareag \
    LANG=en_US.utf8

# Create user and group
RUN groupadd -g 1724 sagadmin && \
    useradd -u 1724 -m -g 1724 -d $SAG_HOME -c "SoftwareAG Admin" sagadmin

# Switch to user
USER 1724

# Switch to install directory
WORKDIR $SAG_HOME
