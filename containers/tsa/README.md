# Terracotta BigMemory Max

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 9510 | Terracotta Server Array port |
| 9520 | JMX port |
| 9530 | Group port |
| 9540 | Management port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size in MB | 128 |
| JAVA_MAX_MEM | Maximum Java heap size in MB | 512 |
| LICENSE_BASE64 | License file base64-encoded | |
| TC_NODE_NAME | Terracotta node name (when using multiple nodes) | |
| TC_NODES | Terracotta nodes list (comma-separated hostnames) | |
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/Terracotta/server/backup | Terracotta backups |
| /opt/softwareag/Terracotta/server/data | Terracotta data |
| /opt/softwareag/Terracotta/server/index | Terracotta index |

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
| LICENSES_BASE64 | Licenses ZIP file base64-encoded | |
| LICENSES_URL | Licenses ZIP file URL | |

## Useful links

- [Terracotta BigMemory Max 4.3 documentation](https://documentation.softwareag.com/onlinehelp/Rohan/terracotta_438/bigmemory-max/webhelp/index.html)
