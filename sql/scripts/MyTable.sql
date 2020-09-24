USE acme;
GO

CREATE TABLE MyTable(
  Id nvarchar(max),
  Value nvarchar(max)
);
GO

INSERT INTO dbo.MyTable (Id, Value)
    VALUES ('88', 'Hello world!');

INSERT INTO dbo.MyTable (Id, Value)
    VALUES ('99', 'Hello world!');