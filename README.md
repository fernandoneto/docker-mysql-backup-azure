# docker-mysql-backup-azure

# variables you must define when you run the container

- CONTAINER
- BACKUP_INTERVAL
- DB_NAME
- DB_USER
- DB_PASSWORD
- PATH_DATEPATTERN
- AZURE_STORAGE_ACCOUNT
- AZURE_STORAGE_ACCESS_KEY

# variables to change port or host

- MYSQL_PORT_3306_TCP_ADDR
- MYSQL_PORT_3306_TCP_PORT

# example of running a container

docker run --rm -ti --name=mysql-backup \
  -e "AZURE_STORAGE_ACCOUNT=" \
  -e "AZURE_STORAGE_ACCESS_KEY=" \
  -e "CONTAINER=" \
  -e "BACKUP_INTERVAL=" \
  -e "DB_NAME=findhit" \
  -e "DB_USER=root" \
  -e "DB_PASSWORD=findhit" \
  -e "PATH_DATEPATTERN=%Y/%m" \
  --link (mysql_container):mysql \
  fernandoneto/mysql-backup
