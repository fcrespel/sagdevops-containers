# Internal Data Store (Elasticsearch)

## Ports

The following ports are exposed by this container.

| Port | Description |
| ---- | ----------- |
| 9240 | Elasticsearch HTTP port |
| 9340 | Elasticsearch Transport port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| ES_JAVA_OPTS | Elasticsearch JVM options | |
| cluster.initial_master_nodes | Elasticsearch cluster initial master nodes | |
| discover.seed_hosts | Elasticsearch discovery seed hosts | localhost:9340 |
| node.name | Elasticsearch node name | |

For other options, refer to the Elasticsearch documentation.

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/InternalDataStore/data | Elasticsearch data |
| /opt/softwareag/InternalDataStore/logs | Elasticsearch logs |

## Useful links

- [Data Store 10.5 documentation](https://documentation.softwareag.com/webmethods/api_gateway/yai10-5/10-5_API_Gateway_webhelp/api-gateway-integrated-webhelp/_api_gtw_integrated_webhelp_diba2.1.010.html)
- [Elasticsearch 7.2 documentation](https://www.elastic.co/guide/en/elasticsearch/reference/7.2/settings.html)
