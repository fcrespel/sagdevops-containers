# API Gateway Kibana

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 9405 | Kibana HTTP port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| TIMEZONE | Timezone name (e.g. Europe/Paris) | UTC |
| elasticsearch.hosts | Elasticsearch hosts | http://localhost:9240 |
| elasticsearch.username | Elasticsearch username | |
| elasticsearch.password | Elasticsearch password | |

For other options, refer to the Kibana documentation.

## Build arguments

The following arguments can be used when building the container image.

| Argument | Description | Default value |
| -------- | ----------- | ------------- |
| BASE_IMAGE | Base image (base) | |
| BUILDER_IMAGE | Builder image (apigw) | |

## Useful links

- [Kibana 7.x documentation](https://www.elastic.co/guide/en/kibana/7.x/settings.html)
