### OS image for all SoftwareAG products

# Build arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Set install directory
ENV SAG_HOME=/opt/softwareag

# Create user and group
RUN groupadd -g 1724 sagadmin && \
    useradd -u 1724 -m -g 1724 -d $SAG_HOME -c "SoftwareAG Admin" sagadmin

# Switch to user
USER 1724

# Switch to install directory
WORKDIR $SAG_HOME
