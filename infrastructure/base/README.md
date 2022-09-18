# Base image

This directory contains the base image used by all subsequent images.

It installs common system packages, defines initial environment variables, and creates the main user and installation directory.

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base OS image | registry.access.redhat.com/ubi8/ubi |
