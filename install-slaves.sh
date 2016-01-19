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

rm -rf slaves
rm -rf slave$ClusterStack.host
	
i=0
while [ $i -lt $N ]
do
	echo "start slave$ClusterStack$i container..."
        docker run -idt --dns $DNS_IP  -P --name slave$ClusterStack$i -v /etc/localtime:/etc/localtime:ro -h slave$ClusterStack$i.mydomain.com spark-slave:$IMAGE_VERSION &> /dev/null
	ip=$(docker inspect slave$ClusterStack$i | grep "IPAddress" | sed -ns '1p' |cut -f4 -d'"')
        echo $ip slave$ClusterStack$i.mydomain.com >> slave$ClusterStack.host
        echo slave$ClusterStack$i.mydomain.com >> slaves
	((i++))
done 



scp slave$ClusterStack.host root@$DNS_IP:/etc/dnsmasq.hosts/ 
ssh root@$DNS_IP 'service dnsmasq restart'

rm -f slave$ClusterStack.host
