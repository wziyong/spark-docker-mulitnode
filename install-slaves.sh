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
        cpu1=`expr $i \* 2`
        cpu2=`expr $cpu1 + 1`
	echo "start slave$ClusterStack$i container...with $cpu1 $cpu2"
        docker run -idt --dns $DNS_IP  -P -m=2G --memory-swap=2G --cpuset-cpus="$cpu1,$cpu2" --name slave$ClusterStack$i -v /etc/localtime:/etc/localtime:ro -h slave$ClusterStack$i.mydomain.com spark-slave:$IMAGE_VERSION  &> /dev/null
	ip=$(docker inspect slave$ClusterStack$i | grep "IPAddress" | sed -ns '1p' |cut -f4 -d'"')
        echo $ip slave$ClusterStack$i.mydomain.com >> slave$ClusterStack.host
        echo slave$ClusterStack$i.mydomain.com >> slaves
	((i++))
done 



scp slave$ClusterStack.host root@$DNS_IP:/etc/dnsmasq.hosts/ 
ssh root@$DNS_IP 'service dnsmasq restart'

rm -f slave$ClusterStack.host
