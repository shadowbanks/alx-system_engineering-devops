-- Create a bd and table, also grant holberton_user SELECT permission
CREATE DATABASE IF NOT EXISTS tyrell_corp;
USE tyrell_corp;
CREATE TABLE IF NOT EXISTS nexus6(
	ID INT;
	);
GRANT SELECT ON tyrell_corp.* TO 'holberton_user'@'localhost';
