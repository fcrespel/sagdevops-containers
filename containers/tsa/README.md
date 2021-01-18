# Terracotta BigMemory Max

## Ports

The following ports are exposed by this container.

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

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/Terracotta/server/backup | Terracotta backups |
| /opt/softwareag/Terracotta/server/data | Terracotta data |
| /opt/softwareag/Terracotta/server/index | Terracotta index |

## Useful links

- [Terracotta BigMemory Max 4.3 documentation](https://documentation.softwareag.com/onlinehelp/Rohan/terracotta_438/bigmemory-max/webhelp/index.html)
