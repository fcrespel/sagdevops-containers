# Hello World

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| HELLO_NAME | Name to say hello to when starting container | default |

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (java) | |
| BUILDER_IMAGE | Builder image (cc-builder) | |
| __hello_name | Name to say hello to when building container | default |

## Useful links

- [Command Central 10.11 documentation](https://documentation.softwareag.com/webmethods/command_central/cce10-11/10-11_Command_Central_webhelp/index.html)
