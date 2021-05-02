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
| REPO_USERNAME | Empower or mirror username | |
| REPO_PASSWORD | Empower or mirror password | |
| REPO_PRODUCT_URL | Product repository URL | |
| REPO_PRODUCT_NAME | Product repository name | products |
| REPO_FIX_URL | Fix repository URL | https://sdc.softwareag.com/updates/prodRepo |
| REPO_FIX_NAME | Fix repository name | fixes |
| LICENSES_URL | Licenses ZIP file URL | |

## Useful links

- [Deployer 10.5 documentation](https://documentation.softwareag.com/webmethods/deployer/wdy10-5/10-5_Deployer_webhelp/index.html)
