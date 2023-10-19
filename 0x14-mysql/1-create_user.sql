-- Create a MySQL user with all priviledge
CREATE USER IF NOT EXISTS 'holberton_user'@'localhost' IDENTIFIED BY 'projectcorrection280hbtn';
GRANT REPLICATION CLIENT ON *.* TO 'holberton_user'@'localhost';
-- GRANT ALL PRIVILEGES ON *.* TO 'holberton_user'@'localhost' WITH GRANT OPTION;
