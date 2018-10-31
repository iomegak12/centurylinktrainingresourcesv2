-- v3
-- Order System

CREATE TABLE [dbo].[OrderInformation](
[OrderID] [int] NOT NULL,
[CustomerID] [int] NOT NULL
)
GO

INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (123, 1)
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (149, 2)
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (857, 2)
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (321, 1)
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (564, 8)
GO

SELECT * FROM dbo.OrderInformation;
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Prestige@123';

CREATE DATABASE SCOPED CREDENTIAL ElasticDBQueryCred
WITH IDENTITY = 'iomegaadmin',
SECRET = 'Prestige123';

CREATE EXTERNAL DATA SOURCE MyElasticDBQueryDataSrc WITH
(TYPE = RDBMS,
LOCATION = 'iomegasqlserverv2.database.windows.net',
DATABASE_NAME = 'iomegasqldatabasev2',
CREDENTIAL = ElasticDBQueryCred,
);

CREATE EXTERNAL TABLE [dbo].[CustomerInformation]
( [CustomerID] [int] NOT NULL,
[CustomerName] [varchar](50) NOT NULL,
[Company] [varchar](50) NOT NULL)
WITH
( DATA_SOURCE = MyElasticDBQueryDataSrc)

SELECT OrderInformation.CustomerID, 
	OrderInformation.OrderId, 
	CustomerInformation.CustomerName, CustomerInformation.Company
FROM OrderInformation
INNER JOIN CustomerInformation
ON CustomerInformation.CustomerID = OrderInformation.CustomerID
