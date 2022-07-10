### OS image for all SoftwareAG products

# Build arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Install updates
RUN yum -y update &&\
    yum clean all

# Install EPEL repository
RUN source /etc/os-release &&\
    if [ "${VERSION_ID:0:1}" = "7" ]; then yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm; fi

# Install packages
RUN yum -y install file gettext hostname initscripts iproute jq less libxslt net-tools psmisc rsync unzip which &&\
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
