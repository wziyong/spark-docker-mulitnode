FROM spark-base:0.0.1

MAINTAINER wziyong <wziyong@126.com>

# move all confugration files into container
ADD files/* /tmp/

ENV SPARK_INSTALL /usr/local/spark

RUN mv /tmp/slaves $SPARK_INSTALL/conf/slaves

EXPOSE 7077 8080 

