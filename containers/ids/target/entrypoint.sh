#!/bin/bash

# Register in Command Central
if [ "$CC_AUTO_REGISTER" = "1" ]; then
    $SAG_HOME/register.sh
fi

# Parse env vars
declare -a es_opts
while IFS='=' read -r envvar_key envvar_value; do
  if [[ "$envvar_key" =~ ^[a-z0-9_]+\.[a-z0-9_]+ || "$envvar_key" == "processors" ]]; then
    if [[ ! -z $envvar_value ]]; then
      es_opt="-E${envvar_key}=${envvar_value}"
      es_opts+=("${es_opt}")
    fi
  fi
done < <(env)

# Start server
PIDFILE=$SAG_HOME/InternalDataStore/bin/elasticsearch.pid
exec $SAG_HOME/InternalDataStore/bin/elasticsearch --pidfile $PIDFILE "${es_opts[@]}" "$@"
