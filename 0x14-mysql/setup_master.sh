#!/usr/bin/env bash
# primary - web-01 ""Comment out bind-address""
# replica - web-02
# replica bd ``tyrell_corp``

# comment out bind-address for now (according to the task)
sed -i "/s/^bind-address/# bind-address/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# replace localhost address to slave server ip
sed -i "/s/127.0.0.1/54.174.169.156/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# uncomment server-id (each servers master/slave must have a unique id
sed -i "/s/# server-id/server-id/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# enable log_bin (slave needs it to update itself) uncomment the line
sed -i "/s/# log_bin/log_bin/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# uncomment binlog_do_db
sed -i "/s/# binlog_do_db/binlog_do_db/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# replace binlog_do_bd's value(include_database_name) to db name (tyrell_corp)
sed -i "/s/include_database_name/tyrell_corp/" /etc/mysql/mtsql.conf.d/mysqld.cnf

sudo service mysql restart

echo "FLUSH TABLES WITH READ LOCK" | mysql -uroot -hlocalhost -p
echo "SHOW MASTER STATUS" | mysql -uroot -hlocalhost -p

#export the databse(take a snapshot)
mysqldump -u root tyrell_corp > sudo /tmp/tyrell_corp.sql

echo "UNLOCK TABLES" | mysql -uroot -hlocalhost -p

scp /tmp/tyrell_corp.sql ubuntu@54.174.169.156:/tmp/
