# Docker-mysql-backup-azure

# Variables you must define when you run the container

- $DB_PASSWORD - db password
- $DB_USER - db user name
- $DB_NAME - db name you want backup
- $CONTAINER - container name in azure storage
- $AZURE_STORAGE_ACCOUNT -
- $AZURE_STORAGE_ACCESS_KEY -
- $MYSQL_PORT - 3306
- $MYSQL_HOST - host where mysql is running

# Example of running

```bash
docker run -rm --name mysql-backup \
-e "DB_PASSWORD=" \
-e "DB_USER=" \
-e "DB_NAME=" \
-e "AZURE_STORAGE_ACCOUNT="
-e "AZURE_STORAGE_ACCESS_KEY="
-e "CONTAINER=" \
-e "MYSQL_PORT=3306" \
-e "MYSQL_HOST=" \
fernandoneto/docker-mysql-backup-azure

```
