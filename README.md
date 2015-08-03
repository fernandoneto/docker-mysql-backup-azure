# Docker-mysql-backup-azure

mysql container to backup your database to Microsoft Azure Storare

# Variables you must define when you run the container

- `$DB_PASSWORD` - The password to connect with Mysql
- `$DB_USER` - The username to connect with Mysql
- `$DB_NAME` - Database name
- `$CONTAINER` - Container name in azure
- `$AZURE_STORAGE_ACCOUNT` - Name of Azure Storare Account
- `$AZURE_STORAGE_ACCESS_KEY` - Acess Key for Storage Account
- `$MYSQL_PORT` - Port to connect with Mysql. default 3306  
- `$MYSQL_HOST` - Host where mysql is running
- `$FILENAME` - Name to file in Azure Storage. Default name default-date +"%Y-%m-%d_%H-%M"`
output will be `default-2015-08-03_17-58`

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
