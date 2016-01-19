#!/bin/bash
. install-cfg.sh

echo "start master container..."
docker run -idt --dns $DNS_IP  -P --name master -v /etc/localtime:/etc/localtime:ro -h master.mydomain.com spark-master:$IMAGE_VERSION &> /dev/null

ip=$(docker inspect master | grep "IPAddress" | sed -ns '1p' |cut -f4 -d'"')
echo $ip master.mydomain.com > /etc/dnsmasq.hosts/master.host

service dnsmasq restart
