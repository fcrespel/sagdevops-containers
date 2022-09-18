# API Gateway

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 5555 | Primary HTTP port |
| 9999 | Diagnostic HTTP port |
| 8075 | JMX port |
| 9072 | API Gateway UI HTTP port |
| 9073 | API Gateway UI HTTPS port |
| 8092 | SPM HTTP port |
| 8093 | SPM HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| JAVA_MIN_MEM | Minimum Java heap size in MB | 512 |
| JAVA_MAX_MEM | Maximum Java heap size in MB | 512 |
| LICENSE_BASE64 | License XML file base64-encoded | |
| apigw_cluster_name | Cluster name | APIGatewayTSAcluster |
| apigw_cluster_aware | Enable clustering using Terracotta Server Array | true |
| apigw_cluster_tsaUrls | Terracotta Server Array URLs (comma-separated) | |
| apigw_cluster_sessTimeout | Inactive session timeout in minutes | 60 |
| apigw_cluster_actionOnStartupError | Action when cluster is not available at startup (shutdown, standalone, quiesce) | standalone |
| apigw_cluster_esClusterName | Embedded Elasticsearch cluster name | SAG_EventDataStore |
| apigw_cluster_initialMasterNodes | Embedded Elasticsearch initial master nodes | localhost |
| apigw_discovery_zen_ping_unicast_hosts | Embedded Elasticsearch discovery seed hosts | localhost:9340 |
| apigw_elasticsearch_hosts | Elasticsearch hosts as host:port,host:port,... | localhost:9240 |
| apigw_elasticsearch_autostart | Start embedded Elasticsearch when API Gateway starts | true |
| apigw_elasticsearch_http_username | Username for Elasticsearch HTTP authentication | |
| apigw_elasticsearch_http_password | Password for Elasticsearch HTTP authentication | |
| apigw_elasticsearch_http_keepAlive | Use persistent connection to Elasticsearch | true |
| apigw_elasticsearch_http_keepAliveMaxConnections | Maximum number of persistent connections to Elasticsearch | 50 |
| apigw_elasticsearch_http_keepAliveMaxConnectionsPerRoute | Maximum number of persistent connections per HTTP route to Elasticsearch | 15 |
| apigw_elasticsearch_http_connectionTimeout | Connection timeout to connect to Elasticsearch in milliseconds | 10000 |
| apigw_elasticsearch_http_socketTimeout | Socket (read) timeout to connect to Elasticsearch in milliseconds | 30000 |
| apigw_elasticsearch_http_maxRetryTimeout | Maximum time to retry to connect to Elasticsearch in milliseconds | 100000 |
| apigw_elasticsearch_https_enabled | Use HTTPS to connect to Elasticsearch | false |
| apigw_elasticsearch_https_keystoreFilepath | Keystore path for Elasticsearch TLS authentication | |
| apigw_elasticsearch_https_keystorePassword | Keystore password for Elasticsearch TLS authentication | |
| apigw_elasticsearch_https_keystoreAlias | Keystore alias for Elasticsearch TLS authentication | |
| apigw_elasticsearch_https_truststoreFilepath | Trust store path for Elasticsearch HTTPS connection | |
| apigw_elasticsearch_https_truststorePassword | Trust store password for Elasticsearch HTTPS connection | |
| apigw_elasticsearch_https_enforceHostnameVerification | Enable host name verification for Elasticsearch HTTPS connection | false |
| apigw_elasticsearch_outboundProxy_enabled | Enable outbound proxy to connect to Elasticsearch | true |
| apigw_elasticsearch_outboundProxy_alias | Proxy alias to use to connect to Elasticssearch | |
| apigw_elasticsearch_sniff_enable | Enable detection of other nodes to connect to Elasticsearch | true |
| apigw_elasticsearch_sniff_timeInterval | Interval between node detection attempts in milliseconds | 60000 |
| apigw_elasticsearch_clientHttpResponseSize | Maximum HTTP client response size in MB | 100 |
| apigw_kibana_dashboardInstance | Kibana URL | http://localhost:9405 |
| apigw_kibana_autostart | Start embedded Kibana when API Gateway starts | true |
| apigw_kibana_elasticsearch_hosts | Elasticsearch hosts | localhost:9240 |
| apigw_kibana_elasticsearch_username | Username for Elasticsearch HTTP authentication | |
| apigw_kibana_elasticsearch_password | Password for Elasticsearch HTTP authentication | |
| apigw_kibana_elasticsearch_sslCert | SSL certificate path for Elasticsearch TLS authentication | |
| apigw_kibana_elasticsearch_sslKey | SSL private key path for Elasticsearch TLS authentication | |
| apigw_kibana_elasticsearch_sslCA | SSL CA bundle path for Elasticsearch HTTPS connection | |
| apigw_terracotta_license_filename | Terracotta license file name (in $SAG_HOME/common/conf) | |

## Volumes

Using a dedicated volume is recommended for the following paths.

| Path | Description |
| ---- | ----------- |
| /opt/softwareag/IntegrationServer/instances/apigateway/cacheStore | Cache persistence |
| /opt/softwareag/IntegrationServer/instances/apigateway/db | Derby databases |
| /opt/softwareag/IntegrationServer/instances/apigateway/logs | Server logs |
| /opt/softwareag/InternalDataStore/data | Embedded Elasticsearch data |
| /opt/softwareag/InternalDataStore/logs | Embedded Elasticsearch logs |

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
| LICENSES_BASE64 | Licenses ZIP file base64-encoded | |
| LICENSES_URL | Licenses ZIP file URL | |

## Useful links

- [API Gateway 10.5 documentation](https://documentation.softwareag.com/webmethods/api_gateway/yai10-5/10-5_API_Gateway_webhelp/index.html)
