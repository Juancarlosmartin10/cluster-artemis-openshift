#!/bin/sh
set -e

export IP=${IP:="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"}
export MASTER_IP=${MASTER_IP:="echo $MASTER_IP"}

# In case this is running in a non standard system that automounts
# empty volumes like OpenShift, restore the configuration into the 
# volume
sed -i "s/<connector name=\"local-connector\">tcp:\/\/0.0.0.0:61617/<connector name=\"local-connector\">tcp:\/\/${IP}:61617/g" ../etc/broker.xml
sed -i "s/<acceptor name=\"local-acceptor\">tcp:\/\/0.0.0.0:61617/<acceptor name=\"local-acceptor\">tcp:\/\/${IP}:61617/g" ../etc/broker.xml
sed -i "s/<connector name=\"master-connector\">tcp:\/\/0.0.0.0:61616/<connector name=\"master-connector\">tcp:\/\/${MASTER_IP}:61616/g" ../etc/broker.xml


exec "$@"
