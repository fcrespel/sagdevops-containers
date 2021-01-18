# Universal Messaging

## Ports

The following ports are exposed by this container.

| Port | Description |
| ---- | ----------- |
| 9000 | Instance port |
| 9988 | JMX port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size in MB | 1024 |
| JAVA_MAX_MEM | Maximum Java heap size in MB | 1024 |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/UniversalMessaging/server/default/data | Universal Messaging data |

## Useful links

- [Universal Messaging 10.5 documentation](https://documentation.softwareag.com/onlinehelp/Rohan/num10-5/10-5_UM_webhelp/index.html)
