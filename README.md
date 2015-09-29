# Docker-mysql-backup-azure

container to backup your mysql database's to Microsoft Azure Storare.

# Container startup explained

* You can run this container in 2 modes:
    - ONE_SHOOT - the container will backup your db and stop
    - CONTINUOUS - the container will start and use a cronjob to schedule a backup window and will run until you stop it.
* Mysql will acess to the host where is database you want to backup
* Mysql will dump the database to this container and compress it using gzip
* Using azure-cli the file will be uploaded to Azure Storage

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
- _`$ONE_SHOOT`_ - If true the container make the backup and exit, else the container still running and schedule a job in crontab. default false
a backup window.
- _`$BACKUP_WINDOW`_ - What time should backup run. you should use crontab format, so see [documentation](http://www.freebsd.org/cgi/man.cgi?crontab(5). default value every day at 6 am.

# Example of running

```bash
docker run -rm --name mysql-backup \
-e "DB_PASSWORD=backup" \
-e "DB_USER=backup" \
-e "DB_NAME=backup" \
-e "ONE_SHOOT=true" \
-e "FILENAME=backup"
-e "AZURE_STORAGE_ACCOUNT=teste-azure"
-e "AZURE_STORAGE_ACCESS_KEY=ashdgashdgasdsa--dadcdsfsd/sdfd--"
-e "CONTAINER=sql-backup" \
-e "MYSQL_HOST=test.mysql.com" \
fernandoneto/docker-mysql-backup-azure:latest

```

This will upload to Azure Storare a file named `default-2015-08-04_09-47.sql.gz` and after that the
container will stop.

### Building image

```bash
docker build -t fernandoneto/docker-mysql-backup-azure .
```
