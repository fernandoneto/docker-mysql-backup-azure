#!/bin/bash

DATETIME=`date +"%Y-%m-%d_%H"`

if [ "$MYSQL_PORT" == "" ]; then
    export MYSQL_PORT="3306";
fi

if [ "$FILENAME" == "" ]; then
    export FILENAME="default";
fi

if [ "$NO_PASSWORD" == "" ]; then
    export NO_PASSWORD="false";
fi

make_backup () {

    export FILENAME={{FILENAME}}
    export CONTAINER={{CONTAINER}}
    export MYSQL_HOST={{MYSQL_HOST}}
    export MYSQL_PORT={{MYSQL_PORT}}
    export DB_USER={{DB_USER}}
    export DB_PASSWORD={{DB_PASSWORD}}
    export DB_NAME={{DB_NAME}}
    export DEBUG={{DEBUG}}
    export AZURE_STORAGE_ACCOUNT={{AZURE_STORAGE_ACCOUNT}}
    export AZURE_STORAGE_ACCESS_KEY={{AZURE_STORAGE_ACCESS_KEY}}

    if [ "$DEBUG" == "true" ]; then
        echo "######################################"
        echo "FILENAME = $FILENAME"
        echo "CONTAINER = $CONTAINER"
        echo "MYSQL_HOST = $MYSQL_HOST"
        echo "MYSQL_PORT = $MYSQL_PORT"
        echo "DB_USER = $DB_USER"
        echo "DB_PASSWORD = $DB_PASSWORD"
        echo "AZURE_STORAGE_ACCOUNT = $AZURE_STORAGE_ACCOUNT"
        echo "AZURE_STORAGE_ACCESS_KEY = $AZURE_STORAGE_ACCESS_KEY "
        echo "DB_NAME = $DB_NAME"
        echo "######################################"
    fi

    if [ "$NO_PASSWORD" == "true" ]; then

        mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER $DB_NAME > $FILENAME-$DATETIME.sql;

    else

        mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER --password=$DB_PASSWORD $DB_NAME > $FILENAME-$DATETIME.sql;

    fi

    # exit if last command have problems
    if  [ "$?" != "0" ]; then
        echo "Error occurred in database dump process. Exiting now"
        exit 1
    fi
    # compress the file
    gzip -9 $FILENAME-$DATETIME.sql
    # Send to cloud storage
    /usr/local/bin/azure storage blob upload $FILENAME-$DATETIME.sql.gz $CONTAINER -c "DefaultEndpointsProtocol=https;BlobEndpoint=https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/;AccountName=$AZURE_STORAGE_ACCOUNT;AccountKey=$AZURE_STORAGE_ACCESS_KEY"

    if  [ "$?" != "0" ]; then
        exit 1
    fi
    # Remove file to save space
    rm -fR *.sql.gz

}

make_backup;
