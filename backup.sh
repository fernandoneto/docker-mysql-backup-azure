#!/bin/bash

DATETIME=`date +"%Y-%m-%d_%H-%M"`
FILENAME=$DATETIME.sql

mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER --password="$DB_PASSWORD" $DB_NAME > $FILENAME

  if  [ "$?" != "0" ]; then
    exit 1
  fi

gzip $FILENAME

  if  [ "$?" != "0" ]; then
    exit 1
  fi

azure storage blob upload $FILENAME.gz $CONTAINER

  if  [ "$?" != "0" ]; then
    exit 1
  fi
