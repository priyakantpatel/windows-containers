GO
--Cretae ContainerTestDB Database
USE [ContainerTestDB]
GO
/****** Object:  User [gMSAContG]    Script Date: 8/3/2018 2:07:23 PM ******/
CREATE USER [gMSAContG] FOR LOGIN [DEVBOX\gMSAContG$] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [gMSAContG]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [gMSAContG]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 8/3/2018 2:07:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

GO

INSERT INTO [dbo].[Product] ([Name]) VALUES (N'Apple')
INSERT INTO [dbo].[Product] ([Name]) VALUES (N'Banana')
INSERT INTO [dbo].[Product] ([Name]) VALUES (N'Tea')
INSERT INTO [dbo].[Product] ([Name]) VALUES (N'Orange')
INSERT INTO [dbo].[Product] ([Name]) VALUES (N'Mango')
GO


