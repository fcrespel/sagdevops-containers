### Java image for all SoftwareAG products

# Build arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Target image
FROM $BASE_IMAGE

# Set environment variables
ENV JAVA_HOME=$SAG_HOME/jvm/jvm
ENV PATH=$PATH:$JAVA_HOME/bin

# Copy JVM from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/jvm/ $SAG_HOME/jvm/
