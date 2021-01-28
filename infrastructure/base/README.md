# Base image

This directory contains the base image used by all subsequent images.

It installs common system packages, defines initial environment variables, and creates the main user and installation directory.

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (centos:7) | |
