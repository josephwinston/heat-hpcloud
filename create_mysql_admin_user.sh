#!/bin/bash

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

source /root/localrc

DEB_PASS=`cat /etc/mysql/debian.cnf | grep password | awk '{print $3}' | head -1`
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${DEB_PASS}'"
mysqladmin -u root password ${DATABASE_ROOT_PASSWORD}
mysqladmin -u root -h `hostname` password ${DATABASE_ROOT_PASSWORD}
