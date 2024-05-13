docker exec -i master_container mysql -uroot -proot_password -e "CREATE USER 'replication_user'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'replication_password';"
docker exec -i master_container mysql -uroot -proot_password -e "GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';"

docker exec -i master_container mysql -uroot -proot_password -e "CREATE DATABASE IF NOT EXISTS my_database;"
docker exec -i read_replica_container mysql -uroot -proot_password -e "CREATE DATABASE IF NOT EXISTS my_database;"

docker exec -i read_replica_container mysql -uroot -proot_password -e "\
USE my_database; \
\
CREATE TABLE IF NOT EXISTS users ( \
    id INT AUTO_INCREMENT PRIMARY KEY, \
    username VARCHAR(50) NOT NULL, \
    email VARCHAR(100) NOT NULL, \
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP \
);"

docker exec -i master_container mysql -uroot -proot_password -e "\
USE my_database; \
\
CREATE TABLE IF NOT EXISTS users ( \
    id INT AUTO_INCREMENT PRIMARY KEY, \
    username VARCHAR(50) NOT NULL, \
    email VARCHAR(100) NOT NULL, \
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP \
);"