# docker compose and mssql database seed

- run: `docker-compose up`
- check console logs and after 15secs the database will be created and seeded
- mssql connection : `127.0.0.1,14335` (user: sa/Abcd1234!)
- `SELECT * FROM [acme].[dbo].[MyTable]`
- CSV file should have encoding 'UTF-8 with BOM' and CRLF (EOL sequence)

The database will only be created/seeded once!

## database scripts:
- [.\sql\init.sql](.\sql\init.sql)
- [.\sql\scripts\MyTable.sql](.\sql\scripts\MyTable.sql)

(existing sql databases can be converted to scripts using [this method](https://dzone.com/articles/generate-database-scripts-with-data-in-sql-server))