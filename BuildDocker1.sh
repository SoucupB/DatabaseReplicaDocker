docker build -t master_instance -f Dockerfile1 .
docker run -d --name master_container master_instance

docker exec -it master_container mysql -u root -p < BuildMysql.sql

