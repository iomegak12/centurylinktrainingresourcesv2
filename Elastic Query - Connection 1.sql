-- v2
-- CRM System

CREATE TABLE [dbo].[CustomerInformation](
[CustomerID] [int] NOT NULL,
[CustomerName] [varchar](50) NULL,
[Company] [varchar](50) NULL
CONSTRAINT [CustID] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
)

INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (1, 'Jack', 'ABC')
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (2, 'Steve', 'XYZ')
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (3, 'Lylla', 'MNO')

SELECT * FROM dbo.CustomerInformation;
