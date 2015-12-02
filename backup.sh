#!/bin/bash

if [ "$BACKUP_WINDOW" == "" ]; then

    BACKUP_WINDOW="0 6 * * * ";

fi

if  [ "$ONE_SHOOT" == "true" ]; then

    . /backup/functions.sh;
    exit 0

else

    sed 's,{{MYSQL_HOST}},'"${MYSQL_HOST}"',g' -i /backup/variable.sh
    sed 's,{{MYSQL_PORT}},'"${MYSQL_PORT}"',g' -i /backup/variable.sh
    sed 's,{{DB_USER}},'"${DB_USER}"',g' -i /backup/variable.sh
    sed 's,{{DB_PASSWORD}},'"${DB_PASSWORD}"',g' -i /backup/variable.sh
    sed 's,{{DB_NAME}},'"${DB_NAME}"',g' -i /backup/variable.sh
    touch /var/log/cron.log;
    echo "$BACKUP_WINDOW /backup/variable.sh & /backup/functions.sh >> /var/log/cron.log 2>&1" >> job;
    echo "" >> job
    crontab job;
    tail -f /var/log/cron.log;
    exit $?

fi
