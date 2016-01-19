FROM spark-base:0.0.1

MAINTAINER wziyong <wziyong@126.com>

# move all confugration files into container
ADD files/* /tmp/

ENV SPARK_INSTALL /usr/local/spark

RUN chmod +x /tmp/spark-env.sh
RUN mv /tmp/spark-env.sh $SPARK_INSTALL/conf/spark-env.sh

EXPOSE 8081 

