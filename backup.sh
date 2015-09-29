#!/bin/bash

. /functions.sh

if  [ "$ONE_SHOOT" == "true" ]; then
    make_backup;
    exit 0;
fi

# scheduele backup window
crontab -l | { cat; echo "$BACKUP_WINDOW /backup/functions.sh"; } | crontab -;

cron -f -L 8

exit $?
