-- Create a MySQL user with all priviledge
CREATE USER IF NOT EXISTS 'replica_user'@'%' IDENTIFIED BY 'noluadE#$12';
GRANT REPLICATION CLIENT ON *.* TO 'replica_user'@'%';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
-- GRANT ALL PRIVILEGES ON *.* TO 'holberton_user'@'localhost' WITH GRANT OPTION;
