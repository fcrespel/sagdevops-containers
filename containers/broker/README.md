# Broker

## Ports

The following ports are exposed by this container.

| Port | Description |
| ---- | ----------- |
| 6847 | Broker TLS port with client certificate authentication |
| 6848 | Broker TLS port |
| 6849 | Broker primary port |
| 6850 | Broker monitor |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| BROKER_DATA_DIR | Directory for data and config stores | /opt/softwareag/Broker/data |
| BROKER_CONFIG_SIZE | Config store size | 1G |
| BROKER_CONFIG_PARAMS | Config store params | |
| BROKER_DATA_SIZE | Data store size | 4G |
| BROKER_DATA_PARAMS | Data store params | async,max_cache_size=512 |
| BROKER_SERVER_PARAMS | Server awbroker.cfg config as key=value key=value ... | max-memory-size=1024 max-recv-events=400 |
| BROKER_NAME | Broker name | default |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/Broker/data | Directory for data and config stores |

## Useful links

- [Broker 10.5 documentation](https://documentation.softwareag.com/webmethods/broker/pif10-5/10-5_Broker_webhelp/index.html)
