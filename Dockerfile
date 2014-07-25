FROM ubuntu:14.04

# Perform the apt-get installation here so that Docker can cache for us. 
RUN apt-get --quiet update
RUN apt-get --quiet --assume-yes install \
 bsdmainutils \
 python-setuptools \
 python-eventlet \
 python-greenlet \
 python-httplib2 \
 python-iso8601 \
 python-lxml \
 python-sqlalchemy \
 python-paste \
 python-routes \
 python-webob \
 python-yaml \
 python-mysqldb \
 python-dev \
 python-pip \
 git-core \
 python-setuptools \
 gcc \
 libc6-dev \
 libxml2-dev \
 libxslt-dev \
 libz-dev \
 python-prettytable \
 mysql-server \
 rabbitmq-server
 
WORKDIR /root
RUN git clone --quiet git://github.com/openstack/heat.git
ADD ./templates /usr/local/sbin/
ADD ./install-heat /usr/local/sbin/
ADD ./start-heat /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/install-heat
RUN chmod a+x /usr/local/sbin/start-heat

RUN /usr/local/sbin/install-heat
CMD /usr/local/sbin/start-heat