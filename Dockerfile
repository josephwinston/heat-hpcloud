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

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

WORKDIR /root
RUN git clone --quiet git://github.com/openstack/heat.git
WORKDIR /root/heat
RUN pip install -r requirements.txt
RUN pip install --quiet -r test-requirements.txt
RUN python setup.py develop --quiet
RUN pip install --quiet python-heatclient
RUN pip install heat-cfntools

ADD ./my.cnf /etc/mysql/conf.d/my.cnf
ADD ./mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ADD ./create_mysql_admin_user.sh /root/
ADD ./install-heat /usr/local/sbin/
ADD ./start-heat /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/install-heat
RUN chmod a+x /usr/local/sbin/start-heat
RUN chmod a+x /root/create_mysql_admin_user.sh
RUN /usr/local/sbin/install-heat
CMD /usr/local/sbin/start-heat