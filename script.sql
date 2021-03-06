USE [master]
GO
/****** Object:  Database [Assignment1_NguyenPhiHung]    Script Date: 2021-03-15 7:05:27 PM ******/
CREATE DATABASE [Assignment1_NguyenPhiHung]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment1_NguyenPhiHung', FILENAME = N'D:\SQL2019\Assignment1_NguyenPhiHung.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Assignment1_NguyenPhiHung_log', FILENAME = N'D:\SQL2019\Assignment1_NguyenPhiHung_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment1_NguyenPhiHung].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET QUERY_STORE = OFF
GO
USE [Assignment1_NguyenPhiHung]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetInvoiceDetailID]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnGetInvoiceDetailID]()
returns varchar(7) 
as
begin
	declare @ID varchar(7)
	if (select count(InvoiceDetailID) from InvoiceDetail) = 0
		set @ID = '0'
	else
		select @ID = max(right(InvoiceDetailID, 4)) from InvoiceDetail
		select @ID = case
			when @ID >= 0 and @ID < 9 then 'IVD000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9 and @ID < 99 then 'IVD00' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99 and @ID < 999 then 'IVD0' + convert(char, convert(int, @ID) + 1)
			when @ID >= 199 and @ID < 9999 then 'IVD' + convert(char, convert(int, @ID) + 1)
		end
	return @ID
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetItemID]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnGetItemID]()
returns varchar(6)
as
begin
	declare @ID varchar(6)
	if (select count(ItemID) from Item) = 0
		set @ID = '0'
	else
		select @ID = max(right(ItemID, 4)) from Item
		select @ID = case
			when @ID >= 0 and @ID < 9 then 'IT000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9 and @ID < 99 then 'IT00' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99 and @ID < 999 then 'IT0' + convert(char, convert(int, @ID) + 1)
			when @ID >= 199 and @ID < 9999 then 'IT' + convert(char, convert(int, @ID) + 1)
		end
	return @ID
end
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [varchar](6) NOT NULL,
	[BuyTime] [date] NOT NULL,
	[TotalPrice] [int] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetail]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetail](
	[InvoiceDetailID] [varchar](7) NOT NULL,
	[InvoiceID] [varchar](6) NOT NULL,
	[ItemID] [varchar](6) NOT NULL,
	[ItemPrice] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [varchar](6) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[Image] [varchar](200) NOT NULL,
	[Price] [int] NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[ItemCategoryID] [varchar](10) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[CreatedDate] [date] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
	[ItemStatusID] [varchar](10) NOT NULL,
	[UpdatedDate] [date] NULL,
	[UpdatedUserID] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCategory]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCategory](
	[ItemCategoryID] [varchar](10) NOT NULL,
	[ItemCategoryName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemStatus]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemStatus](
	[ItemStatusID] [varchar](10) NOT NULL,
	[ItemStatusName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[UserGenderID] [varchar](10) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[UserTypeID] [varchar](10) NULL,
	[UpdateDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGender]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGender](
	[UserGenderID] [varchar](10) NOT NULL,
	[UserGenderName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserGenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 2021-03-15 7:05:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[UserTypeID] [varchar](10) NOT NULL,
	[UserTypeName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Invoice] ([InvoiceID], [BuyTime], [TotalPrice], [UserID], [Address]) VALUES (N'IV1', CAST(N'2021-03-15' AS Date), 27000, N'test', N'VN')
INSERT [dbo].[Invoice] ([InvoiceID], [BuyTime], [TotalPrice], [UserID], [Address]) VALUES (N'IV2', CAST(N'2021-03-15' AS Date), 27000, N'test', N'VN')
INSERT [dbo].[InvoiceDetail] ([InvoiceDetailID], [InvoiceID], [ItemID], [ItemPrice]) VALUES (N'IVD0001', N'IV1', N'IT0001', 11500)
INSERT [dbo].[InvoiceDetail] ([InvoiceDetailID], [InvoiceID], [ItemID], [ItemPrice]) VALUES (N'IVD0002', N'IV1', N'IT0003', 15500)
INSERT [dbo].[InvoiceDetail] ([InvoiceDetailID], [InvoiceID], [ItemID], [ItemPrice]) VALUES (N'IVD0003', N'IV2', N'IT0002', 27000)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0001', N'Bia 333', N'333.jpg', 11500, N'lon', N'IC0', 0, N'Hương thơm lúa mạch dịu nhẹ cùng bọt bia mịn màng. Nồng độ cồn của loại bia này 
là 5,3%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0002', N'Bia Saigon Special', N'SaigonSpecial.jpg', 13500, N'lon', N'IC0', 48, N'100% lúa mạch. Nồng độ cồn của loại bia này là 4,9%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0003', N'Bia Tiger', N'Tiger.jpg', 15500, N'lon', N'IC0', 49, N'Mùi vị đắng của men bia, hoà quyện chút ngọt dịu của lúa mạch. Nồng độ cồn là 5%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0004', N'Bia Sapporo', N'Sapporo.jpg', 16500, N'lon', N'IC0', 50, N'Hương vị mạch nha đậm đà, thơm ngon, tươi mát, hạt bọt bia siêu mịn. 
Nồng độ cồn của loại bia này là 5,2%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0005', N'Bia Heineken', N'Heineken.jpg', 17500, N'lon', N'IC0', 50, N'Vị đắng vô cùng dịu nhẹ, hương thơm lúa mạch cực kỳ kích thích đầu lưỡi.
Nồng độ cồn của loại bia này là 5%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0006', N'Bia Budweiser', N'Budweiser.jpg', 17000, N'lon', N'IC0', 50, N'Hương vị thơm ngon của trái cây nhiệt đới, lên men bằng các loại mạch nha.
Nồng độ cồn của loại bia này là 5%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0007', N'Bia Strongbow', N'Strongbow.jpg', 18000, N'chai', N'IC0', 50, N'Lên men từ trái cây đem lại cảm giác ngọt dịu, thanh mát và thuần khiết.
Nồng độ cồn của loại bia này là 4.5%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0008', N'Bia Hà Nội', N'HN.jpg', 11000, N'lon', N'IC0', 50, N'Vị men đậm đà đặc trưng của malt đại mạch hảo hạng và hương hoa houblon lôi cuốn.
Nồng độ cồn của loại bia này là 4.6%', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0009', N'Sting', N'Sting.jpg', 9000, N'lon', N'IC9', 50, N'Mùi vị thơm ngon, sảng khoái. Giúp cơ thể bù đắp nước, bổ sung năng lượng, 
vitamin C và E', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0010', N'Number1', N'Number1.jpg', 8500, N'chai', N'IC9', 50, N'sự kết hợp của Vitamin B3, Taurine, Inositol và Caffein giúp nạp nhanh năng lượng, 
chinh phục mọi thử thách', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0011', N'Wake up 247', N'247.jpg', 8500, N'lon', N'IC9', 50, N'Hương cà phê có thành phần tự nhiên giúp cơ thể bù đắp nước, bổ sung năng lượng, 
xua tan cơn khát và cảm giác mệt mỏi', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0012', N'Pepsi', N'Pepsi.jpg', 10000, N'lon', N'IC9', 50, N'Gây ấn tượng với lượng ga cực mạnh, giải nhiệt cực nhanh trong những ngày hè nóng bức', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0013', N'Mirinda', N'Mirinda.jpg', 10000, N'lon', N'IC9', 50, N'Giúp tràn đầy năng lượng, căng tràn sức sống ', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0014', N'7Up', N'7Up.jpg', 10000, N'lon', N'IC9', 50, N'Hương bạc hà mát lạnh, hòa quyện với hương chanh, tạo nên một thức uống cực sướng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0015', N'Redbull', N'Redbull.jpg', 10000, N'lon', N'IC9', 50, N'Thành phần tự nhiên, mùi vị thơm ngon giúp cơ thể bù đắp nước, bổ sung năng lượng, 
vitamin C và E, xua tan cơn khát và cảm giác mệt mỏi', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0016', N'Warrior', N'Warrior.jpg', 10000, N'lon', N'IC9', 50, N'Vị dâu với các loại vitamin B3, B6, B12, cung cấp năng lượng dồi dào cho một ngày
dài năng động', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0017', N'C2', N'C2.jpg', 9000, N'chai', N'IC9', 50, N'Tinh chất có sẵn trong trà xanh kết hợp với nguồn vitamin C dồi dào, giúp bổ sung năng lượng 
cho cả ngày dài vận động', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0018', N'Vinamilk', N'Vinamilk.jpg', 28900, N'hộp', N'IC6', 50, N'Là thực phẩm giàu dinh dưỡng, cực kỳ an toàn cho sức khỏe', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0019', N'Dutch Lady', N'DL.jpg', 28500, N'hộp', N'IC6', 50, N'Tạo sự tươi ngon tự nhiên và thuần khiết cho người tiêu dùng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0020', N'Nuti', N'Nuti.jpg', 28500, N'hộp', N'IC6', 50, N'Hương vị thơm ngon, béo ngậy. Bổ sung vitamin A, D3, Kẽm cùng nhiều vi dưỡng chất
thiết yếu khác giúp xương và răng chắc khoẻ, sáng mát, tăng sức đề kháng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0021', N'Milo', N'Milo.jpg', 26500, N'hộp', N'IC6', 50, N'lúa mạch kết hợp với cacao và nguồn dưỡng chất thiên nhiên từ sữa, mầm lúa mạch
giúp giải phóng năng lượng, tăng cường chức năng cơ và hệ xương', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0022', N'Fami', N'Fami.jpg', 19000, N'hộp', N'IC6', 50, N'Gấp đôi canxi để làm gì. 100% đậu nành hạt chọn lọc thêm sánh mịn, thơm ngon', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0023', N'TH True Milk', N'THTM.jpg', 35000, N'hộp', N'IC6', 50, N'Sữa thanh trùng giữ vẹn nguyên hương vị tươi mát của sữa tươi sạch', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0024', N'Dalat Milk', N'DLM.jpg', 39000, N'hộp', N'IC6', 50, N'100% sữa bò tươi từ cao nguyên, hương vị sữa thơm ngon và giá trị dinh 
dưỡng cao', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0025', N'Bánh quy Cosy', N'Cosy.jpg', 46000, N'hộp', N'IC2', 50, N'Kết hợp với nhiều hương vị khác nhau mang đến cho người tiêu dùng sự 
lựa chọn đa dạng phù hợp', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0026', N'Bánh bông lan Solite', N'Solite.jpg', 50000, N'hộp', N'IC2', 50, N'Với hương vị thơm ngon, giàu dinh dưỡng và cung cấp năng lượng
dồi dào cho một ngày làm việc hứng khởi', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0027', N'Bánh bông lan Hura', N'Hura.jpg', 47000, N'hộp', N'IC2', 50, N'Hương vị thơm ngon mềm xốp cùng lớp kem ngọt ngào mang lại nguồn 
dinh dưỡng trọn vẹn', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0028', N'Bánh xốp nhân socala Nabati', N'Nabati.jpg', 43000, N'hộp', N'IC2', 50, N'Hương vị thơm ngon hấp dẫn, kích thích vị giác, bổ sung vi 
chất dinh dưỡng cho cơ thể khỏe mạnh', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0029', N'Bánh quế nhân socola Deka', N'Deka.jpg', 12000, N'hộp', N'IC2', 50, N'Hương chuối thơm thoang thoảng, quyện với socola đặc tan chảy 
trong miệng khi ăn tạo cảm giác ngon khó tả', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0030', N'Bánh gạo One One', N'OneOne.jpg', 29500, N'bịch', N'IC2', 50, N'Thơm ngon giòn tan với nhiều hương vị khác nhau phù hợp với khẩu vị 
của người Việt Nam', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0031', N'Bánh ChocoPie', N'ChocoPie.jpg', 54000, N'hộp', N'IC2', 50, N'Đem đến cho bạn vị thơm ngon, béo ngậy của socola bên ngoài cùng 
vị ngọt, dai của lớp kẹo dẻo bên trong', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0032', N'Bánh Custas', N'Custas.jpg', 63500, N'hộp', N'IC2', 50, N'Là chiếc bánh bông lan rất được yêu thích bởi hương vị thơm ngon từ vỏ
bánh cho đến lớp kem trứng ngọt ngào, mềm mịn và đậm vị được làm từ trứng tươi', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0033', N'Bánh kem xốp Tipo', N'Tipo.jpg', 28500, N'hộp', N'IC2', 50, N'Lớp bánh giòn tan hoà quyện với phô mai nhập khẩu từ châu Âu làm 
nên hương vị thơm ngon ấn tượng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0034', N'Bánh Quy Dừa', N'Dua.jpg', 35000, N'hộp', N'IC2', 50, N'Được làm từ nguyên liệu cao cấp. Bánh giòn xốp, hương thơm béo của dừa 
hoà quyện với vị ngậy từ bơ', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0035', N'Kẹo gừng Migita', N'Migita.jpg', 5300, N'gói', N'IC3', 50, N'Hương vị thơm ngon, hợp khẩu vị mọi lứa tuổi', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0036', N'Kẹo socola Dynamite Chews', N'Dynamite.jpg', 14500, N'gói', N'IC3', 50, N'Vị sô cô la hòa quyện cùng hương bạc hà thơm mát, mang
đến cảm giác thích thú', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0037', N'Kẹo bạc hà DoubleMint', N'DoubleMint.jpg', 35000, N'hộp', N'IC3', 50, N'Kẹo chua thanh, mát lạnh sẽ mang lại cho bạn sự tỉnh táo,
hơi thở thơm mát', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0038', N'Kẹo sữa Milkita', N'Milkita.jpg', 30000, N'bịch', N'IC3', 50, N'Lớp giấy có in hình chú bò sữa ngộ nghĩnh, kết hợp với màu sắc 
đặc trưng của các hương vị trái cây tạo nên sự thu hút cho người dùng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0039', N'Kẹo dẻo Want Want QQ', N'QQ.jpg', 3500, N'gói', N'IC3', 50, N'Vị mềm, dẻo và hương trái cây thơm ngon sẽ là món ăn vặt yêu thích
của tất cả mọi người, hương vị ngọt ngào, hấp dẫn khó quên', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0040', N'Kẹo dừa Bến Tre', N'BT.jpg', 32000, N'hộp', N'IC3', 50, N'Với hương vị béo ngậy nguyên chất của nước cốt dừa, tạo vị đậm đà cho 
viên kẹo', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0041', N'Kẹo sing-gum Cool Air', N'CA.jpg', 50000, N'bịch', N'IC3', 50, N'Hương bạc hà khuynh diệp the mát giúp thông cổ, mát họng, góp 
phần làm sạch khoang miệng, mang đến hơi thở thơm mát', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0042', N'Kẹo sing-gum DoubleMint', N'double.jpg', 15000, N'gói', N'IC3', 50, N'Với nhiều hương vị mới lạ, giúp bạn giữ được hơi thở thơm 
mát', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0043', N'Arabica', N'Arabica.jpg', 25000, N'ly', N'IC4', 50, N'Mùi thơm quyến rũ, nồng nàn, vị nhạt, hơi chua nhưng lập tực thấy được vị 
đắng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0044', N'Culi', N'Culi.jpg', 25000, N'ly', N'IC4', 50, N'Vị đắng ngắt, hương thơm say lòng người, nước đen sóng sánh', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0045', N'Cherry', N'Cherry.jpg', 23000, N'ly', N'IC4', 50, N'Cà phê dậy lên mùi hương thoang thoảng khi pha và có vị chua của Cherry tạo
ra một cảm hứng thật sảng khoái', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0046', N'Moka', N'Moka.jpg', 20000, N'ly', N'IC4', 50, N'Mang theo mình vị đắng nhẹ, xem lẫn trong đó là một chút chua thanh và có cả vị 
béo của phần dầu bên trong hạt', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0047', N'Robusta', N'Robusta.jpg', 25000, N'ly', N'IC4', 50, N'Cà phê được sấy trực tiếp chứ không lên men, vì vậy loại cà phê này có vị 
khá đắng, uống đậm đà', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0048', N'Espresso', N'Espresso.jpg', 26000, N'ly', N'IC4', 50, N'Được pha chế bằng cách dùng nước nóng nén dưới áp suất cao làm hương vị 
cafe rất đậm, đặc trưng là trên mặt có một lớp bọt màu nâu đóng phần quan trọng tạo hương thơm cho cà phê', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0049', N'Snack khoai tây vị rong biển Greens A', N'Greens.jpg', 8500, N'bịch', N'IC8', 50, N'Giòn rụm thơm ngon với gia vị đậm đà hoàn 
hảo', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0050', N'Snack khoai tây vị cua xào ớt Peke Potato Chips', N'Chips.jpg', 20000, N'lon', N'IC8', 50, N'Năng lượng 400.1kcal/80g', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0051', N'Snack khoai tây vị phô mai Slide', N'Slide.jpg', 31000, N'lon', N'IC8', 50, N'Chứa nhiều chất dinh dưỡng tốt cho sức khỏe. 
Từng miếng khoai giòn giòn, mằn mặn giữ nguyên mùi vị nguyên thủy của khoai tây.', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0052', N'Snack mực tẩm vị cay ngọt Bento', N'Bento.jpg', 25000, N'bịch', N'IC8', 50, N'Vị cay cay, ngọt ngọt và mùi thơm hấp dẫn của mực 
tẩm sẽ kích thích vị giác', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0053', N'Snack tôm thái JoJo', N'JoJo.jpg', 4600, N'bịch', N'IC8', 50, N'Thương hiệu OISHI, sản xuất tại Việt Nam', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0054', N'Snack da cá vị ớt xanh Pati', N'Pati.jpg', 36000, N'bịch', N'IC8', 50, N'Bạn sẽ cảm nhận được hương vị hấp dẫn, sự giòn rụm của
da cá, cộng thêm vị mặn và béo của lòng đỏ trứng muối ngon làm bạn không thể nào cưỡng lại', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0055', N'Snack Cá Full Fish vị BBQ', N'Fish.jpg', 16000, N'gói', N'IC8', 50, N'Rất ngon khi đãi khách ngày tết ', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0056', N'Kem cuộn Thái Lan', N'Thai.jpg', 35000, N'cốc', N'IC5', 50, N'Kem ngon chủ yếu ở lớp kem mỏng, mịn và độ xốp của kem với nhiều 
hương vị thơm ngon', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0057', N'Kem mochi', N'mochi.jpg', 10000, N'viên', N'IC5', 50, N'Vỏ bánh mềm dẻo dai bọc ngoài nhân kem mát lạnh ngọt lịm người', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0058', N'Kem thịt', N'thit.jpg', 39000, N'cốc', N'IC5', 50, N'Vị mặn hơi khác lạ, trong kem sẽ có những toping thịt heo, ngoài ra còn 
có thịt bò', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0059', N'Kem Gelato', N'Gelato.jpg', 50000, N'cốc', N'IC5', 50, N'Với hàm lượng béo thấp, gelato không bị đông cứng như kem và tan chảy 
trong miệng nhanh hơn, cảm giác nhẹ nhàng, thanh mát chứ không hề ngậy', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0060', N'Kem trà sữa chân châu đường đen', N'tra.jpg', 170000, N'hộp', N'IC5', 50, N'Hương vị của kem thì thơm ngọt béo và thơm đậm mùi
caramen. Kem đã được đông lạnh nhưng trân châu không hề bị cứng mà vẫn mềm dẻo', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0061', N'Kem phô mai The Cheese Bar Lavelee', N'Lavelee.jpg', 39000, N'hộp', N'IC5', 50, N'Kem que mát lạnh, thơm ngon giúp bạn dẹp tan 
cơn khát vào những ngày nắng nóng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0062', N'Kem múi sầu riêng Gella Stick', N'Stick.jpg', 35000, N'que', N'IC5', 50, N'Tạo hình giống múi sầu riêng cộng thêm hương vị không
khác gì đang ăn múi sầu riêng thật, cắn vào cảm giác mát lạnh, đậm đà ngay cổ họng', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0063', N'Kem bi Dippin Dots', N'Dippin.jpg', 50000, N'ly', N'IC5', 50, N'Mùi Singum với trái cây thích hợp cho em nhỏ', CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[Item] ([ItemID], [ItemName], [Image], [Price], [Unit], [ItemCategoryID], [Quantity], [Description], [CreatedDate], [ExpirationDate], [ItemStatusID], [UpdatedDate], [UpdatedUserID]) VALUES (N'IT0064', N'fsdfsdf', N'close_1.png', 123, N'ly', N'IC5', 50, N'fesf', CAST(N'2021-03-15' AS Date), CAST(N'2021-01-01' AS Date), N'IS0', NULL, NULL)
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC0', N'Beer')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC2', N'Cakes')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC3', N'Candies')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC4', N'Coffee')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC5', N'Ice Cream')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC6', N'Milk')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC8', N'Snack ')
INSERT [dbo].[ItemCategory] ([ItemCategoryID], [ItemCategoryName]) VALUES (N'IC9', N'Soda')
INSERT [dbo].[ItemStatus] ([ItemStatusID], [ItemStatusName]) VALUES (N'IS0', N'active')
INSERT [dbo].[ItemStatus] ([ItemStatusID], [ItemStatusName]) VALUES (N'IS1', N'inactive')
INSERT [dbo].[User] ([UserID], [Password], [FullName], [UserGenderID], [Address], [UserTypeID], [UpdateDate]) VALUES (N'admin', N'123456', N'Cô Vân Admin', N'UG0', N'VN', N'UT0', CAST(N'2021-03-15' AS Date))
INSERT [dbo].[User] ([UserID], [Password], [FullName], [UserGenderID], [Address], [UserTypeID], [UpdateDate]) VALUES (N'hung17k', N'phihung17k', N'Nguyễn Phi Hùng', N'UG0', N'VN', N'UT1', CAST(N'2021-03-15' AS Date))
INSERT [dbo].[User] ([UserID], [Password], [FullName], [UserGenderID], [Address], [UserTypeID], [UpdateDate]) VALUES (N'test', N'123456', N'Cô Vân User', N'UG1', N'VN', N'UT1', CAST(N'2021-03-15' AS Date))
INSERT [dbo].[User] ([UserID], [Password], [FullName], [UserGenderID], [Address], [UserTypeID], [UpdateDate]) VALUES (N'test2', N'test2', N'Nguyễn Phi Hùng', N'UG0', N'VN', N'UT0', CAST(N'2021-03-15' AS Date))
INSERT [dbo].[UserGender] ([UserGenderID], [UserGenderName]) VALUES (N'UG0', N'MALE')
INSERT [dbo].[UserGender] ([UserGenderID], [UserGenderName]) VALUES (N'UG1', N'FEMALE')
INSERT [dbo].[UserGender] ([UserGenderID], [UserGenderName]) VALUES (N'UG2', N'UNKNOWN')
INSERT [dbo].[UserType] ([UserTypeID], [UserTypeName]) VALUES (N'UT0', N'admin')
INSERT [dbo].[UserType] ([UserTypeID], [UserTypeName]) VALUES (N'UT1', N'user')
ALTER TABLE [dbo].[Invoice] ADD  DEFAULT (getdate()) FOR [BuyTime]
GO
ALTER TABLE [dbo].[InvoiceDetail] ADD  CONSTRAINT [InvoiceDetailID]  DEFAULT ([dbo].[fnGetInvoiceDetailID]()) FOR [InvoiceDetailID]
GO
ALTER TABLE [dbo].[Item] ADD  CONSTRAINT [ItemID]  DEFAULT ([dbo].[fnGetItemID]()) FOR [ItemID]
GO
ALTER TABLE [dbo].[Item] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Item] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD FOREIGN KEY([ItemCategoryID])
REFERENCES [dbo].[ItemCategory] ([ItemCategoryID])
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD FOREIGN KEY([ItemStatusID])
REFERENCES [dbo].[ItemStatus] ([ItemStatusID])
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD FOREIGN KEY([UpdatedUserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([UserGenderID])
REFERENCES [dbo].[UserGender] ([UserGenderID])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserType] ([UserTypeID])
GO
USE [master]
GO
ALTER DATABASE [Assignment1_NguyenPhiHung] SET  READ_WRITE 
GO
