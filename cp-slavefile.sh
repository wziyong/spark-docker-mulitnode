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
	echo "cp slaves to slave$ClusterStack$i container..."
        docker cp slaves slave$ClusterStack$i:/usr/local/hadoop/etc/hadoop/slaves
	((i++))
done 


