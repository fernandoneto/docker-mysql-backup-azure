#!/bin/bash

if [ "$BACKUP_WINDOW" == "" ]; then
    BACKUP_WINDOW="0 6 * * * ";
fi

if  [ "$ONE_SHOOT" == "true" ]; then
    . /backup/functions.sh;
    exit 0
else
    # scheduele backup window
    touch /var/log/cron.log;
    crontab -l | { cat; echo "$BACKUP_WINDOW /backup/functions.sh >> /var/log/cron.log 2>&1"; } | crontab -;
    tail -f /var/log/cron.log;
    exit $?
fi
