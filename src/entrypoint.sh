#!/bin/bash

set -m

/run/miscellaneous/restore_config.sh
/run/miscellaneous/edit_config.sh
test -f /usr/share/kibana/plugins/x-pack/package.json || /usr/share/kibana/bin/kibana-plugin install x-pack
/run/miscellaneous/wait_for_elasticsearch.sh

# Run as user "logstash" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	set -- gosu kibana tini -- "$@"
fi
$@ &

fg
