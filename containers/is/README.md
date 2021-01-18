# Integration Server

## Ports

The following ports are exposed by this container.

| Port | Description |
| ---- | ----------- |
| 5555 | Primary HTTP port |
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

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/IntegrationServer/instances/default/cacheStore | Cache persistence |
| /opt/softwareag/IntegrationServer/instances/default/db | Derby databases (embedded, audit, CSQ ...) |
| /opt/softwareag/IntegrationServer/instances/default/DocumentStore | Document store (resubmit, triggers ...) |
| /opt/softwareag/IntegrationServer/instances/default/logs | Server logs |
| /opt/softwareag/IntegrationServer/instances/default/WmRepository4 | Legacy repository |
| /opt/softwareag/IntegrationServer/instances/default/XAStore | XA transaction store |

## Useful links

- [Integration Server 10.5 documentation](https://documentation.softwareag.com/webmethods/microservices_container/msc10-5/10-5_MSC_PIE_webhelp/index.html)
