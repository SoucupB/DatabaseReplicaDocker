docker build -t read_replica_instance -f Dockerfile2 .
docker run -d --name read_replica_container read_replica_instance