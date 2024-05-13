docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' master_container
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' read_replica_container