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
| SAG_IS_CONFIG_PROPERTIES | Configuration Variables Template file location | /opt/softwareag/IntegrationServer/application.properties |

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

## Useful links

- [Microservices Runtime 10.5 documentation](https://documentation.softwareag.com/webmethods/microservices_container/msc10-5/10-5_MSC_PIE_webhelp/index.html)
