#!/bin/bash

# set -xeuo pipefail

graceful_shutdown() {
    echo "calling graceful shutdown"
    curl -v -X PUT -d '"SHUTTING_DOWN"' -H "Content-type: application/json" http://localhost:8081/v1/info/state -H X-Presto-User:name
}
trap graceful_shutdown SIGTERM

# set +e
grep -s -q 'node.id' /etc/presto/node.properties
NODE_ID_EXISTS=$?
set -e

NODE_ID=""
if [[ ${NODE_ID_EXISTS} != 0 ]] ; then
    NODE_ID="-Dnode.id=${HOSTNAME}"
fi

exec /usr/lib/presto/bin/launcher run --etc-dir /etc/presto ${NODE_ID} "$@"

