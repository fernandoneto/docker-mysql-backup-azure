#!/bin/bash

. /backup/functions.sh

if [ "$BACKUP_WINDOW" == "" ]; then
    BACKUP_WINDOW="0 6 * * * ";
fi

if  [ "$ONE_SHOOT" == "true" ]; then
    make_backup;
    exit 0;
else
    # scheduele backup window
    crontab -l | { cat; echo "$BACKUP_WINDOW /backup/functions.sh"; } | crontab -

    cron -f -L 8

    exit $?

fi
