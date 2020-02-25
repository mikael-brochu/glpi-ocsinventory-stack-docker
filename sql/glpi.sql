SET @password = LOAD_FILE('/run/secrets/glpi_password');
SET @password = REPLACE(@password, '\n', '');
select @password;

SET @username = 'glpi_admin';

DROP USER IF EXISTS 'glpi_admin';
CREATE USER 'glpi_admin'@'%';
CREATE DATABASE IF NOT EXISTS glpidb;

SET @grantQuery = CONCAT('
        GRANT ALL ON glpidb.* TO "',@username,'"@"%" IDENTIFIED BY "',@password,'" '
        );
PREPARE stmt FROM @grantQuery; EXECUTE stmt; DEALLOCATE PREPARE stmt;
