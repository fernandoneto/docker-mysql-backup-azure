#!/bin/bash

DATETIME=`date +"%Y-%m-%d_%H-%M"`

if [ "$MYSQL_PORT" == "" ]; then
    MYSQL_PORT="3306";
fi

if [ "$FILENAME" == "" ]; then
    FILENAME="default-$DATETIME.sql";
fi

mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER --password=$DB_PASSWORD $DB_NAME > $FILENAME

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
