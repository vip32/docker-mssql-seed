#!/bin/bash
database=acme
wait_time=15s
password=Abcd1234!

# wait for SQL Server to be ready
echo importing data will start in $wait_time...
sleep $wait_time

# todo: check if db exists
if /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -Q "SELECT name FROM sys.databases WHERE name = '$database'" | grep -q $database;
then
    echo database $database already exists: skip initialization and seeding
else
    echo database $database does not exist: starting initialization and seeding

    # run init script to create the db
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i ./init.sql

    # run additional sql scripts
    for entry in "scripts/*.sql"
    do
      echo executing script: $entry
      /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
    done

    #import table data from csv files
    for entry in "data/*.csv"
    do
      # i.e: transform /data/MyTable.csv to MyTable
      shortname=$(echo $entry | cut -f 1 -d '.' | cut -f 2 -d '/')
      tableName=$database.dbo.$shortname
      echo importing $tableName from csv: $entry
      /opt/mssql-tools/bin/bcp $tableName in $entry -c -t',' -F 2 -S 0.0.0.0 -U sa -P $password
    done
fi