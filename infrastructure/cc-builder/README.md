# Command Central Builder

This image contains both a Command Central Server and a Platform Manager (SPM) node to install products into.

It is meant to be used as a builder image for multi-stage builds of products.

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8090 | Command Central HTTP port |
| 8091 | Command Central HTTPS port |
| 8092 | SPM HTTP port (node) |
| 8093 | SPM HTTPS port (node) |
| 8992 | SPM HTTP port (server) |
| 8993 | SPM HTTPS port (server) |

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (cc-server) | |
| NODE_IMAGE | Node image (cc-node) | |

The following arguments can be used when using this image as a base image (onbuild).

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| ADMIN_PASSWORD | Administrator password | |
| REPO_USERNAME | Empower or mirror username | |
| REPO_PASSWORD | Empower or mirror password | |
| REPO_PRODUCT_URL | Product repository URL | |
| REPO_PRODUCT_NAME | Product repository name | products |
| REPO_FIX_URL | Fix repository URL | https://sdc.softwareag.com/updates/prodRepo |
| REPO_FIX_NAME | Fix repository name | fixes |
| LICENSES_URL | Licenses ZIP file URL | |

## Useful links

- [Command Central 10.5 documentation](https://documentation.softwareag.com/webmethods/command_central/cce10-5/10-5_Command_Central_webhelp/index.html)
