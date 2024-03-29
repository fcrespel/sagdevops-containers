# My webMethods Server

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8585 | HTTP port |
| 8586 | HTTPS port |
| 8587 | JMX port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size in MB | 512 |
| JAVA_MAX_MEM | Maximum Java heap size in MB | 512 |
| MWS_DB_TYPE | Database type (oracle, postgresql, mysqlce, ...) | internal |
| MWS_DB_URL | Database JDBC URL | |
| MWS_DB_USERNAME | Database user name | |
| MWS_DB_PASSWORD | Database user password | |
| MWS_DB_NAME | Database name | |
| MWS_USER_PWD_xxx | Password for user xxx (Administrator, SysAdmin, Designer) | |
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/MWS/server/default/data/db | Internal database data |
| /opt/softwareag/MWS/server/default/logs | Server logs |

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

## Useful links

- [My webMethods Server 10.11 documentation](https://documentation.softwareag.com/webmethods/mywebmethods_server/mws10-11/10-11_MWSw/index.html)
