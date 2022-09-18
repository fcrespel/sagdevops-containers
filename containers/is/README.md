# Integration Server

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 5554 | Admin HTTP port (for scripts/tools) |
| 5555 | Primary HTTP port |
| 5556 | Web Services HTTP port |
| 9999 | Diagnostic HTTP port |
| 8075 | JMX port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size in MB | 512 |
| JAVA_MAX_MEM | Maximum Java heap size in MB | 512 |
| IS_JNDI_URL_xxx | JNDI URL for alias xxx | |
| IS_USER_PWD_xxx | Password for user xxx (Administrator, proxyuser, etc.) | |
| LICENSE_BASE64 | License XML file base64-encoded | |
| SYNC_CONFIG | Sync config from image to instance at startup | true |
| SYNC_PACKAGES | Sync packages from image to instance at startup | true |
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |
| WS_HTTP_LB_HOST | Web service provider endpoint hostname | $(hostname -f) |
| WS_HTTP_LB_PORT | Web service provider endpoint port | 5556 |
| WS_HTTPS_LB_HOST | Web service provider endpoint hostname | $(hostname -f) |
| WS_HTTPS_LB_PORT | Web service provider endpoint port | 6555 |
| watt.xxx | Value for Extended Setting xxx (watt.debug.level, etc.) | |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/IntegrationServer/instances/default/cacheStore | Cache persistence |
| /opt/softwareag/IntegrationServer/instances/default/db | Derby databases (embedded, audit, CSQ ...) |
| /opt/softwareag/IntegrationServer/instances/default/DocumentStore | Document store (resubmit, triggers ...) |
| /opt/softwareag/IntegrationServer/instances/default/logs | Server logs |
| /opt/softwareag/IntegrationServer/instances/default/packages | Packages |
| /opt/softwareag/IntegrationServer/instances/default/WmRepository4 | Legacy repository |
| /opt/softwareag/IntegrationServer/instances/default/XAStore | XA transaction store |

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

- [Integration Server 10.5 documentation](https://documentation.softwareag.com/webmethods/microservices_container/msc10-5/10-5_MSC_PIE_webhelp/index.html)
