# Microservices Runtime

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 5555 | Primary HTTP port |
| 9999 | Diagnostic HTTP port |
| 9192 | JMX port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size | 512m |
| JAVA_MAX_MEM | Maximum Java heap size | 512m |
| LICENSE_BASE64 | License XML file base64-encoded | |
| SAG_IS_CONFIG_PROPERTIES | Configuration Variables Template file location | /opt/softwareag/IntegrationServer/application.properties |
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/IntegrationServer/cacheStore | Cache persistence |
| /opt/softwareag/IntegrationServer/db | Derby databases (embedded, audit, CSQ ...) |
| /opt/softwareag/IntegrationServer/DocumentStore | Document store (resubmit, triggers ...) |
| /opt/softwareag/IntegrationServer/logs | Server logs |
| /opt/softwareag/IntegrationServer/replicate/autodeploy | Package auto-deployment directory |
| /opt/softwareag/IntegrationServer/WmRepository4 | Legacy repository |
| /opt/softwareag/IntegrationServer/XAStore | XA transaction store |

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

- [Microservices Runtime 10.11 documentation](https://documentation.softwareag.com/webmethods/microservices_container/msc10-11/10-11_MSC_PIE_webhelp/index.html)
