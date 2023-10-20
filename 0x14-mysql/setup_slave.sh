# primary - web-01 ""Comment out bind-address""
# replica - web-02
# replica bd ``tyrell_corp``

#import the db snapshot
sudo mysql tyrell_corp < /tmp/tyrell_corp.sql


# uncomment server-id (each servers master/slave must have a unique id
sed -i "/s/# server-id/server-id/" /etc/mysql/mtsql.conf.d/mysqld.cnf
sed -i "/s/server-id\t\t1/server-id\t\t2/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# primary - web-01 ""Comment out bind-address""
# replica - web-02
# replica bd ``tyrell_corp``

# enable log_bin (slave needs it to update itself) uncomment the line
sed -i "/s/# log_bin/log_bin/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# uncomment binlog_do_db
sed -i "/s/# binlog_do_db/var/log/mysql/mysql-bin.log/" /etc/mysql/mtsql.conf.d/mysqld.cnf

# replace binlog_do_bd's value(include_database_name) to db name (tyrell_corp)
sed -i "/s/# include_database_name/tyrell_corp/" /etc/mysql/mtsql.conf.d/mysqld.cnf

#Append
sudo echo "relay-log\t\t=/var/log/mysql/mysql-relay-bin.log" >> /etc/mysql/mtsql.conf.d/mysqld.cnf

sudo service mysql restart
