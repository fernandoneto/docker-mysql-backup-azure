make_backup () {

    # dump database
    mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $DB_USER --password=$DB_PASSWORD $DB_NAME > $FILENAME-$DATETIME.sql
    # compress the file
    gzip $FILENAME-$DATETIME.sql
    # Send to cloud storage
    azure storage blob upload $FILENAME-$DATETIME.sql.gz $CONTAINER -c "DefaultEndpointsProtocol=https;BlobEndpoint=https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/;AccountName=$AZURE_STORAGE_ACCOUNT;AccountKey=$AZURE_STORAGE_ACCESS_KEY"

}

make_backup;
