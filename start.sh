#!/bin/bash

#
# Start the heat server
#
# docker run -d --net=host -v `pwd`/logs:/var/log/heat ferry/heatserver
docker run -d -p 8004:8004 -p 8000:8000 -v `pwd`/logs:/var/log/heat ferry/heatserver
ETH0=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
export HEAT_URL=http://${ETH0}:8004/v1/${OS_TENANT_ID}
export OS_NO_CLIENT_AUTH=1

echo export HEAT_URL=http://${ETH0}:8004/v1/${OS_TENANT_ID}
echo export OS_NO_CLIENT_AUTH=1
