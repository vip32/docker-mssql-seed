#!/bin/bash
database=acme
wait_time=15s
password=Abcd1234!

# wait for SQL Server to be ready
echo importing data will start in $wait_time...
sleep $wait_time
echo importing data...

# todo: check if db exists

# run init script to create the db
/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i ./init.sql

# todo: run scripts only of db did not exist

# run additional sql scripts
for entry in "scripts/*.sql"
do
  echo executing $entry
  /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
done

#import table data from csv files
for entry in "data/*.csv"
do
  # i.e: transform /data/MyTable.csv to MyTable
  shortname=$(echo $entry | cut -f 1 -d '.' | cut -f 2 -d '/')
  tableName=$database.dbo.$shortname
  echo importing $tableName from $entry
  /opt/mssql-tools/bin/bcp $tableName in $entry -c -t',' -F 2 -S 0.0.0.0 -U sa -P $password
done