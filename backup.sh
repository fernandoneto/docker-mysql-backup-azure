#!/bin/bash

. /functions.sh

DATETIME=`date +"%Y-%m-%d_%H"`

f [ "$MYSQL_PORT" == "" ]; then
    MYSQL_PORT="3306";
fi

if [ "$FILENAME" == "" ]; then
    FILENAME="default";
fi

if [ "$BACKUP_WINDOW" == "" ]; then
    BACKUP_WINDOW="0  6 * * *";
fi

if  [ "$ONE_SHOOT" == "true" ]; then
    make_backup;
    exit 0;
fi

# scheduele backup window
crontab -l | { cat; echo "$BACKUP_WINDOW /backup/functions.sh"; } | crontab -;

while [ true ]; do
    sleep 3600;
    echo "Hy im still alive since the last time you check me !!!!! "
done
