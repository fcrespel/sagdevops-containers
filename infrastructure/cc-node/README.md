# Command Central Node

This image contains a Platform Manager (SPM) node that can be used to install additional products.

It is meant to be used as a template installation directory by the Command Central Builder image.

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/profiles/SPM/configuration | Platform Manager (SPM) configuration |
| /opt/softwareag/profiles/SPM/data | Platform Manager (SPM) data |

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (base) | |
| BUILDER_IMAGE | Builder image (cc-server) | |
| CC_INSTALLER | Command Central installer file name (without extension) | |
| CC_INSTALLER_URL | Command Central installer URL (without file name) | https://empowersdc.softwareag.com/ccinstallers |
| REPO_USERNAME | Empower or mirror username | |
| REPO_PASSWORD | Empower or mirror password | |
| REPO_PRODUCT_URL | Product repository URL | |
| REPO_PRODUCT_NAME | Product repository name | products |
| REPO_FIX_URL | Fix repository URL | https://sdc.softwareag.com/updates/prodRepo |
| REPO_FIX_NAME | Fix repository name | fixes |

## Useful links

- [Command Central 10.5 documentation](https://documentation.softwareag.com/webmethods/command_central/cce10-5/10-5_Command_Central_webhelp/index.html)
