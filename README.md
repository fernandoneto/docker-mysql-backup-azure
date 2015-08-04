# Docker-mysql-backup-azure

container to backup your mysql database's to Microsoft Azure Storare.

# Environment variables

- _`$DB_PASSWORD`_ - The password to connect with Mysql
- _`$DB_USER`_ - The username to connect with Mysql
- _`$DB_NAME`_ - Database name
- _`$CONTAINER`_ - Container name in azure
- _`$AZURE_STORAGE_ACCOUNT`_ - Name of Azure Storare Account
- _`$AZURE_STORAGE_ACCESS_KEY`_ - Acess Key for Storage Account
- _`$MYSQL_PORT`_ - Port to connect with Mysql. default 3306  
- _`$MYSQL_HOST`_ - Host where mysql is running
- _`$FILENAME`_ - Name to file in Azure Storage. Default name `default-date +"%Y-%m-%d_%H-%M"` output example `default-2015-08-03_17-58`

# Container startup explained

* Mysql will acess to the host where is database you want to backup
* Mysql will dump the database to this container and compress it using gzip
* Using azure-cli the file will be uploaded to Azure Storage
* Container will exit

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

This will upload to Azure Stora a file named `default-2015-08-04_09-47.sql.gz`

## Developing

### Building image

```bash
docker build -t fernandoneto/docker-mysql-backup-azure .
```
