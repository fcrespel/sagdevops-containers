### OS image for all SoftwareAG products

# Build arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Install packages and updates
RUN yum -y update &&\
    yum -y install file gettext iproute less unzip which &&\
    yum -y clean all

# Set install directory
ENV SAG_HOME=/opt/softwareag \
    WM_HOME=/opt/softwareag

# Create user and group
RUN groupadd -g 1724 sagadmin && \
    useradd -u 1724 -m -g 1724 -d $SAG_HOME -c "SoftwareAG Admin" sagadmin

# Switch to user
USER 1724

# Switch to install directory
WORKDIR $SAG_HOME
