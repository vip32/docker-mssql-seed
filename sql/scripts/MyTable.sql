USE acme;
GO

-- table creation can also be done in init.sql

CREATE TABLE MyTable(
  Id nvarchar(max),
  Value nvarchar(max)
);
GO

-- database seeding

INSERT INTO dbo.MyTable (Id, Value)
    VALUES ('88', 'Hello world!');

INSERT INTO dbo.MyTable (Id, Value)
    VALUES ('99', 'Hello world!');