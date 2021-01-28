# Command Central Server

This image contains a Command Central Server and its associated Platform Manager (SPM).

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8090 | Command Central HTTP port |
| 8091 | Command Central HTTPS port |
| 8992 | SPM HTTP port |
| 8993 | SPM HTTPS port |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/sagtools/profiles/CCE/configuration | Command Central configuration |
| /opt/sagtools/profiles/CCE/data | Command Central data |
| /opt/sagtools/profiles/SPM/configuration | Platform Manager (SPM) configuration |
| /opt/sagtools/profiles/SPM/data | Platform Manager (SPM) data |

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (base) | |
| CC_INSTALLER | Command Central installer file name (without extension) | |
| CC_INSTALLER_URL | Command Central installer URL (without file name) | https://empowersdc.softwareag.com/ccinstallers |

## Useful links

- [Command Central 10.5 documentation](https://documentation.softwareag.com/webmethods/command_central/cce10-5/10-5_Command_Central_webhelp/index.html)
