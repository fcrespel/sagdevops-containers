#!/bin/bash

# Parse env vars
declare -a kibana_opts
while IFS='=' read -r envvar_key envvar_value; do
  if [[ "$envvar_key" =~ ^[a-z0-9_]+\.[a-z0-9_]+ ]]; then
    if [[ ! -z $envvar_value ]]; then
      kibana_opt="--${envvar_key}=${envvar_value}"
      kibana_opts+=("${kibana_opt}")
    fi
  fi
done < <(env)

# Run Kibana
exec $SAG_HOME/kibana/bin/kibana "${kibana_opts[@]}" "$@"
