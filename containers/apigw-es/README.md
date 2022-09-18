# API Gateway Data Store (Elasticsearch)

## Ports

The following ports are exposed by this container image.

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
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |
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

- [Data Store 10.11 documentation](https://documentation.softwareag.com/webmethods/api_gateway/yai10-11/10-11_API_Gateway_webhelp/index.html#page/api-gateway-integrated-webhelp%2Fco-administering_datastore.html%23)
- [Elasticsearch 7.x documentation](https://www.elastic.co/guide/en/elasticsearch/reference/7.x/settings.html)
