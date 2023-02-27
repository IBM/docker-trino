#!/bin/bash

set -xeuo pipefail

graceful_shutdown() {
    echo "calling graceful shutdown"
    PORT=$(grep "^http-server.http.port=" /etc/trino/config.properties | cut -d '=' -f2)
    curl -v -X PUT -d '"SHUTTING_DOWN"' -H "Content-type: application/json" http://localhost:$PORT\/v1/info/state -H X-Trino-User:trino
}
trap graceful_shutdown TERM

set +e
grep -s -q 'node.id' /etc/trino/node.properties
NODE_ID_EXISTS=$?
set -e

NODE_ID=""
if [[ ${NODE_ID_EXISTS} != 0 ]] ; then
    NODE_ID="-Dnode.id=${HOSTNAME}"
fi

exec /usr/lib/trino/bin/launcher run --etc-dir /etc/trino ${NODE_ID} "$@"
