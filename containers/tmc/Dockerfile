### Terracotta Management Console image

# Arguments
ARG BASE_IMAGE

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 9889

# Environment variables
ENV TSA_URL=http://tsa:9540

# Add overlay from target directory
ADD --chown=1724:1724 target/ $SAG_HOME/
