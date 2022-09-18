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

# Update timezone
if [ -n "$TIMEZONE" ]; then
    echo "Configuring timezone ($TIMEZONE) ..."
    if [ -e "/usr/share/zoneinfo/$TIMEZONE" ]; then
        cp "/usr/share/zoneinfo/$TIMEZONE" "/etc/localtime"
        echo "Timezone updated: $(date)"
    else
        echo "Unable to find timezone $TIMEZONE at /usr/share/zoneinfo/$TIMEZONE"
        exit 1
    fi
fi

# Run Kibana
exec $SAG_HOME/kibana/bin/kibana "${kibana_opts[@]}" "$@"
