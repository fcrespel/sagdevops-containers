#!/bin/sh -e

# Show console logs immediately
echo "wrapper.console.flush=TRUE" >> $SAG_HOME/Terracotta/server/wrapper/conf/custom_wrapper.conf
