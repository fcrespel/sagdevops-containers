# Asset Build Environment

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /src | Source directory for build (should include a build.sh file) |

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (java) | |
| BUILDER_IMAGE | Builder image (cc-builder) | |

## Useful links

- [Deployer 10.5 documentation](https://documentation.softwareag.com/webmethods/deployer/wdy10-5/10-5_Deployer_webhelp/index.html)
