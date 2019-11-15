#!/bin/sh
set -e

export IP=${IP:="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"}
export SLAVE_IP=${SLAVE_IP:="echo $SLAVE_IP"}


sed -i "s/<connector name=\"local-connector\">tcp:\/\/0.0.0.0:61616/<connector name=\"local-connector\">tcp:\/\/${IP}:61616/g" ../etc/broker.xml
sed -i "s/<acceptor name=\"local-acceptor\">tcp:\/\/0.0.0.0:61616/<acceptor name=\"local-acceptor\">tcp:\/\/${IP}:61616/g" ../etc/broker.xml
sed -i "s/<acceptor name=\"slave-connector\">tcp:\/\/0.0.0.0:61617/<connector name=\"slave-connector\">tcp:\/\/${SLAVE_IP}:61617/g" ../etc/broker.xml
exec "$@"
