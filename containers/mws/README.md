# My webMethods Server

## Ports

The following ports are exposed by this container.

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
| MWS_DB_TYPE | Database type (oracle, postgresql, ...) | postgresql |
| MWS_DB_URL | Database JDBC URL | jdbc:wm:postgresql://mws-db:5432;databaseName=mws |
| MWS_DB_USERNAME | Database user name | mws |
| MWS_DB_PASSWORD | Database user password | mws |
| MWS_DB_NAME | Database name | mws |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/MWS/server/default/logs | Server logs |

## Useful links

- [My webMethods Server 10.5 documentation](https://documentation.softwareag.com/webmethods/mywebmethods_server/mws10-5/10-5_MWSw/index.html)