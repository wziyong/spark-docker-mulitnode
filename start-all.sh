#!/bin/bash

. install-cfg.sh

# run N slave containers
N=$1
ClusterStack=$2

# the defaut node number is 3
if [ $N = 0 ]
then
	N=3
fi

if [ X"$ClusterStack" = X ]
then
   echo "please set Cluster Stack..!"
   exit
fi

	
i=0
while [ $i -lt $N ]
do
	echo "start slave$ClusterStack$i container..."
        docker start slave$ClusterStack$i &> /dev/null
	ip=$(docker inspect slave$ClusterStack$i | grep "IPAddress" | sed -ns '1p' |cut -f4 -d'"')
        echo $ip slave$ClusterStack$i.mydomain.com >> slave$ClusterStack.host
        echo slave$ClusterStack$i.mydomain.com >> slaves
	((i++))
done 



scp slave$ClusterStack.host root@$DNS_IP:/etc/dnsmasq.hosts/ 
ssh root@$DNS_IP 'service dnsmasq restart'

rm -f slave$ClusterStack.host
