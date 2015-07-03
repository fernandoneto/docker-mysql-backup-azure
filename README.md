# docker-mysql-backup-azure

# variables you must define when you run the container

- CONTAINER - Container name in Azure Cloud Storage
- BACKUP_INTERVAL - Time in seconds
- DB_NAME - Database name
- DB_USER - Username
- DB_PASSWORD - Password
- PATH_DATEPATTERN - %Y/%m"
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

###Future features

* You must be able to choose how many backups store in Azure 
