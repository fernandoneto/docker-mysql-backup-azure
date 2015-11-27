#!/bin/bash

DATETIME=`date +"%Y-%m-%d_%H"`

if [ "$MYSQL_PORT" == "" ]; then
    MYSQL_PORT="3306";
fi

if [ "$FILENAME" == "" ]; then
    FILENAME="default";
fi

if [ "$NO_PASSWORD" == "" ]; then
    NO_PASSWORD="false";
fi

make_backup () {

    if [ "$NO_PASSWORD" == "true" ]; then

        mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER $DB_NAME > $FILENAME-$DATETIME.sql;

    else

        mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER --password=$DB_PASSWORD $DB_NAME > $FILENAME-$DATETIME.sql;

    fi

    # compress the file
    gzip -9 $FILENAME-$DATETIME.sql
    # Send to cloud storage
    azure storage blob upload $FILENAME-$DATETIME.sql.gz $CONTAINER -c "DefaultEndpointsProtocol=https;BlobEndpoint=https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/;AccountName=$AZURE_STORAGE_ACCOUNT;AccountKey=$AZURE_STORAGE_ACCESS_KEY"

    if  [ "$?" != "0" ]; then
        exit 1
    fi
    # Remove file to save space
    rm -fR $FILENAME-$DATETIME.sql.gz

}

make_backup;
