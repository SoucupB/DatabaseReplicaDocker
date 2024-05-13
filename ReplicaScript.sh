CHANGE MASTER TO
  MASTER_HOST='172.17.0.2',
  MASTER_USER='replication_user',
  MASTER_PASSWORD='replication_password',
  MASTER_LOG_FILE='binlog.000002',
  MASTER_LOG_POS=4698,
  GET_MASTER_PUBLIC_KEY=1,
  REPLICATE_IGNORE_TABLE='my_database.products';


SHOW MASTER STATUS;

CREATE USER 'replication_user'@'%' IDENTIFIED BY 'replication_password';
CREATE USER 'vasile'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'replication_password';

CREATE USER 'replication_user'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'replication_password';

GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';

START SLAVE;
SHOW SLAVE STATUS\G


GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';


ALTER USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'replication_password';

CREATE USER 'username'@'host' IDENTIFIED WITH 'caching_sha2_password' BY 'password';

SELECT user, host FROM mysql.user;


STOP REPLICA IO_THREAD FOR CHANNEL '';
DROP USER 'replication_user'@'%';