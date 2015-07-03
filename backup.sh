#!/bin/bash

interval=$BACKUP_INTERVAL
dbhost=$MYSQL_PORT_3306_TCP_ADDR
dbport=$MYSQL_PORT_3306_TCP_PORT
dbname=$DB_NAME
dbuser=$DB_USER
dbpass=$DB_PASSWORD
blob=$AZURE_BLOB
container=$CONTAINER
pathpattern=$PATH_DATEPATTERN
count=1

# Variable to filter the oldest backup in blob

# This loop will run forever unless something goes wrong
# if that happens container will be stoped

while [ 1 ]

  do
    datepath=`date +"$pathpattern"`

    datetime=`date +"%Y-%m-%d_%H-%M"`
    filename=$dbname+$datetime.sql

    mysqldump -h $dbhost -P $dbport -u $dbuser --password="$dbpass" $dbname > $filename

    if  [ "$?" != "0" ]; then
      break
    fi

    gzip $filename

    if  [ "$?" != "0" ]; then
      break
    fi

    azure storage blob upload $filename.gz $container && echo "Backup No. $count successfully created at Microsoft Azure $container container"

    if  [ "$?" != "0" ]; then
      break
    fi

    rm $filename.gz

    azure storage blob delete $container $older && echo "Oldest backup successfully removed at Microsoft Azure $container container"

    count=`expr $count + 1`
    sleep $interval

    done
