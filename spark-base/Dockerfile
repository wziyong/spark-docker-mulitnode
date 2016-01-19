# Creates a base centos image with jdk and hadoop
FROM centos:7

MAINTAINER wziyong <wziyong@126.com>

#install ssh
RUN yum install -y openssh-clients

#install sshd 
RUN yum install -y openssh-server

RUN yum install -y which 

RUN yum install -y net-tools

#configure sshd
RUN yum install -y openssl
RUN echo '123456' | passwd --stdin root
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key
#RUN sed -i '/^session\s\+required\s\+pam_loginuid.so/s/^/#/' /etc/pam.d/sshd
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh



#move all files into container /usr/local, including jdk ,configuration files and  hadoop pkg 
ADD files/* /usr/local/

# set jave environment variable 
ENV JAVA_HOME /usr/local/jdk1.7.0_80 
ENV PATH $PATH:$JAVA_HOME/bin


#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
mv /usr/local/ssh_config ~/.ssh/config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#install hadoop 2.71
RUN ln -s /usr/local/spark-1.6.0-bin-hadoop2.6 /usr/local/spark
RUN mv /usr/local/bashrc ~/.bashrc 

EXPOSE 22 
CMD  ["/usr/sbin/sshd", "-D"]

