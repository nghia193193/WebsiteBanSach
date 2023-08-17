USE [master]
GO
/****** Object:  Database [WebProjectST7]    Script Date: 8/17/2023 9:10:56 AM ******/
CREATE DATABASE [WebProjectST7]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebProjectST7', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WebProjectST7.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebProjectST7_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WebProjectST7_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WebProjectST7] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebProjectST7].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebProjectST7] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebProjectST7] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebProjectST7] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebProjectST7] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebProjectST7] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebProjectST7] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebProjectST7] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebProjectST7] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebProjectST7] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebProjectST7] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebProjectST7] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebProjectST7] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebProjectST7] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebProjectST7] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebProjectST7] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WebProjectST7] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebProjectST7] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebProjectST7] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebProjectST7] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebProjectST7] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebProjectST7] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebProjectST7] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebProjectST7] SET RECOVERY FULL 
GO
ALTER DATABASE [WebProjectST7] SET  MULTI_USER 
GO
ALTER DATABASE [WebProjectST7] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebProjectST7] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebProjectST7] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebProjectST7] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebProjectST7] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebProjectST7] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebProjectST7', N'ON'
GO
ALTER DATABASE [WebProjectST7] SET QUERY_STORE = OFF
GO
USE [WebProjectST7]
GO
/****** Object:  Table [dbo].[books]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[books](
	[book_id] [bigint] IDENTITY(1,1) NOT NULL,
	[author] [nvarchar](100) NULL,
	[book_name] [nvarchar](300) NULL,
	[create_at] [date] NULL,
	[image] [varchar](max) NULL,
	[language] [nvarchar](50) NULL,
	[price] [float] NULL,
	[promotional_price] [float] NULL,
	[publisher] [nvarchar](200) NULL,
	[quantity] [int] NULL,
	[rating] [int] NULL,
	[is_selling] [bit] NULL,
	[sold] [int] NULL,
	[update_at] [date] NULL,
	[category_id] [bigint] NULL,
	[store_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_items]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_items](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[count] [int] NULL,
	[create_at] [date] NULL,
	[update_at] [date] NULL,
	[book_id] [bigint] NULL,
	[cart_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[carts]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carts](
	[cart_id] [bigint] IDENTITY(1,1) NOT NULL,
	[create_at] [date] NULL,
	[update_at] [date] NULL,
	[store_id] [bigint] NULL,
	[user_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[category_id] [bigint] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NULL,
	[create_at] [date] NULL,
	[is_delete] [bit] NULL,
	[image] [varchar](max) NULL,
	[update_at] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_items]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_items](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[count] [int] NULL,
	[create_at] [date] NULL,
	[update_at] [date] NULL,
	[book_id] [bigint] NULL,
	[order_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [bigint] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NULL,
	[amount_from_user] [float] NULL,
	[amount_togd] [float] NULL,
	[amount_to_store] [float] NULL,
	[create_at] [date] NULL,
	[is_paid_before] [bit] NULL,
	[phone] [varchar](12) NULL,
	[status] [nvarchar](50) NULL,
	[update_at] [date] NULL,
	[store_id] [bigint] NULL,
	[user_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stores]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stores](
	[store_id] [bigint] IDENTITY(1,1) NOT NULL,
	[is_active] [bit] NULL,
	[avatar] [varchar](max) NULL,
	[create_at] [date] NULL,
	[description] [nvarchar](500) NULL,
	[is_open] [bit] NULL,
	[store_name] [nvarchar](50) NULL,
	[update_at] [date] NULL,
	[owner_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[store_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 8/17/2023 9:10:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NULL,
	[avatar] [varchar](max) NULL,
	[create_at] [date] NULL,
	[email] [varchar](100) NULL,
	[first_name] [nvarchar](20) NULL,
	[is_delete] [bit] NULL,
	[last_name] [nvarchar](50) NULL,
	[password] [varchar](150) NULL,
	[phone] [varchar](12) NULL,
	[reset_password_token] [varchar](255) NULL,
	[role] [varchar](10) NOT NULL,
	[update_at] [date] NULL,
	[username] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[books] ON 

INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (7, N'nkn', N'sach11', CAST(N'2022-12-22' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671959750/itndpuzsnhjox6sotbba.png', N'TIENGviet', 30000, 30000, N'nhagiao', 155, 0, 1, 0, CAST(N'2022-12-26' AS Date), 8, 1)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (8, N'Nguyễn Liên', N'sach1', CAST(N'2022-12-22' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671699048/z1l0oygfonniyii4me3s.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 155, 0, 0, 0, CAST(N'2022-12-22' AS Date), 4, 1)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (9, N'Nguyễn Liên', N'sach334', CAST(N'2022-12-25' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671898776/xcf48yhzs1ddhzbcoemk.jpg', N'Tiếng Việt', 20000, 20000, N'Kim Đồng', 334, 155, 1, 155, CAST(N'2022-12-25' AS Date), 5, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (10, N'Nguyễn Liên', N'sach111', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671874150/m03fkbopwlzyjpczemrp.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 124, 0, 0, 0, NULL, 5, 1)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (34, N'Nguyễn Liên', N'sach116', CAST(N'2022-12-25' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671895231/ecemuvx2lxjmw5odcosw.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 16, 0, 1, 0, CAST(N'2022-12-25' AS Date), 5, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (36, N'Nguyễn Liên', N'sach117', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671895574/yvlygrllhex342bkywrk.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 17, 0, 0, 0, CAST(N'2022-12-25' AS Date), 5, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (37, N'Nguyễn Liên', N'sach117', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671896010/arppogtulfeiuou0noim.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 17, 0, 0, 0, NULL, 4, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (38, N'Nguyễn Liên', N'sach117', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671896055/iiwtzsahfob1kwh6jfh9.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 17, 0, 0, 0, NULL, 4, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (39, N'Nguyễn Liên', N'sach1161', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671897371/ozgwrc67zoyem6q7yqpc.jpg', N'Tiếng Việt', 40000, 40000, N'Kim Đồng', 161, 0, 0, 0, NULL, 4, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (40, N'Nguyễn Liên', N'sach1161', CAST(N'2022-12-24' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671897407/n16yu2gieoapxo0hhjvw.jpg', N'Tiếng Việt', 40000, 40000, N'Kim Đồng', 161, 0, 0, 0, NULL, 4, 2)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (41, N'Nguyễn Liên', N'sach111', CAST(N'2022-12-25' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671958709/ffotbny8b04cbbazsqzq.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 155, 0, 1, 0, NULL, 4, 1)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (42, N'Nguyễn Liên', N'sachstore1', CAST(N'2022-12-25' AS Date), N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671960169/l8mdddnjtsdwhfbwrqru.jpg', N'Tiếng Việt', 30000, 30000, N'Kim Đồng', 116, 0, 1, 0, CAST(N'2022-12-25' AS Date), 5, 1)
INSERT [dbo].[books] ([book_id], [author], [book_name], [create_at], [image], [language], [price], [promotional_price], [publisher], [quantity], [rating], [is_selling], [sold], [update_at], [category_id], [store_id]) VALUES (43, N'Nguyễn Liên', N'sach112up', CAST(N'2022-12-25' AS Date), NULL, N'Tiếng Việt', 20000, 20000, N'Kim Đồng', 114, 111, 1, 111, CAST(N'2022-12-25' AS Date), 4, 1)
SET IDENTITY_INSERT [dbo].[books] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([category_id], [category_name], [create_at], [is_delete], [image], [update_at]) VALUES (4, N'Truyện Tranh', CAST(N'2022-12-25' AS Date), 0, N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671697947/rzir7fcqw7bwrgcx18bx.jpg', CAST(N'2022-12-26' AS Date))
INSERT [dbo].[categories] ([category_id], [category_name], [create_at], [is_delete], [image], [update_at]) VALUES (5, N'Truyện dài', CAST(N'2022-12-22' AS Date), 0, N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671701932/k4oj9oa6v3wpzrs1pe5m.jpg', CAST(N'2022-12-22' AS Date))
INSERT [dbo].[categories] ([category_id], [category_name], [create_at], [is_delete], [image], [update_at]) VALUES (8, N'Sách Khoa học', CAST(N'2022-12-25' AS Date), 0, N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671967331/cxdmlowwxazjol0z3rkx.jpg', NULL)
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[order_items] ON 

INSERT [dbo].[order_items] ([id], [count], [create_at], [update_at], [book_id], [order_id]) VALUES (1, 5, NULL, NULL, 10, 1)
INSERT [dbo].[order_items] ([id], [count], [create_at], [update_at], [book_id], [order_id]) VALUES (2, 4, NULL, NULL, 8, 1)
INSERT [dbo].[order_items] ([id], [count], [create_at], [update_at], [book_id], [order_id]) VALUES (3, 7, NULL, NULL, 8, 2)
INSERT [dbo].[order_items] ([id], [count], [create_at], [update_at], [book_id], [order_id]) VALUES (4, 6, NULL, NULL, 10, 2)
SET IDENTITY_INSERT [dbo].[order_items] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([order_id], [address], [amount_from_user], [amount_togd], [amount_to_store], [create_at], [is_paid_before], [phone], [status], [update_at], [store_id], [user_id]) VALUES (1, N'HCM', 30000, 30000, 30000, CAST(N'2022-12-25' AS Date), 0, N'0123456789', N'shipped', CAST(N'2022-12-26' AS Date), 1, 1)
INSERT [dbo].[orders] ([order_id], [address], [amount_from_user], [amount_togd], [amount_to_store], [create_at], [is_paid_before], [phone], [status], [update_at], [store_id], [user_id]) VALUES (2, N'HN', 40000, 0, 40000, CAST(N'2022-12-26' AS Date), 1, N'0123123111', N'delivered', CAST(N'2022-12-26' AS Date), 1, 1)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[stores] ON 

INSERT [dbo].[stores] ([store_id], [is_active], [avatar], [create_at], [description], [is_open], [store_name], [update_at], [owner_id]) VALUES (1, 1, N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671698428/c2sayssdnigddk0xlsuf.jpg', CAST(N'2022-12-25' AS Date), N'video con meo con', 0, N'nhà hàng winnerz', CAST(N'2022-12-25' AS Date), 1)
INSERT [dbo].[stores] ([store_id], [is_active], [avatar], [create_at], [description], [is_open], [store_name], [update_at], [owner_id]) VALUES (2, 1, N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671790074/dt6eiv7xvtwymg8xd8vn.jpg', CAST(N'2022-12-23' AS Date), N'cửa hàng đồ cũ', 1, N'bán sách conan', CAST(N'2022-12-25' AS Date), 4)
INSERT [dbo].[stores] ([store_id], [is_active], [avatar], [create_at], [description], [is_open], [store_name], [update_at], [owner_id]) VALUES (3, 1, N'https://res.cloudinary.com/dmsv3ph70/image/upload/v1671979128/vv8rklvq8tjgxcgfqedf.png', CAST(N'2022-12-25' AS Date), N'wowmaybaytoghe', 0, N'bán máy bay', CAST(N'2022-12-25' AS Date), 16)
SET IDENTITY_INSERT [dbo].[stores] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [address], [avatar], [create_at], [email], [first_name], [is_delete], [last_name], [password], [phone], [reset_password_token], [role], [update_at], [username]) VALUES (1, N'ktx khu B, Linh Trung, thành phố Thủ Đức', N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671695970/v4ahvhosakpkm7ef3qlf.jpg', CAST(N'2022-12-23' AS Date), N'nguyennghia19391@gmail.com', N'Tam', 0, N'Nguyen Thanh', N'123456', N'0395023922', NULL, N'user', CAST(N'2022-12-23' AS Date), N'thanhtam1223')
INSERT [dbo].[users] ([user_id], [address], [avatar], [create_at], [email], [first_name], [is_delete], [last_name], [password], [phone], [reset_password_token], [role], [update_at], [username]) VALUES (4, N'36 Trường chinh Trần Hưng Đạo', N'https://res.cloudinary.com/de84ozlrg/image/upload/v1671790047/e81ofnzont41hl6ymh0d.jpg', CAST(N'2022-12-25' AS Date), N'nguyennghia19391@gmail.com', N'Van', 0, N'Huynh Minh', N'123456', N'0399345678', NULL, N'USER', CAST(N'2022-12-25' AS Date), N'minhvan123')
INSERT [dbo].[users] ([user_id], [address], [avatar], [create_at], [email], [first_name], [is_delete], [last_name], [password], [phone], [reset_password_token], [role], [update_at], [username]) VALUES (13, N'Ho Chi Minh Minh Minh Minh', N'https://res.cloudinary.com/dmsv3ph70/image/upload/v1671945814/l6vgpa67eeuelkumrtmj.jpg', CAST(N'2022-12-25' AS Date), N'nguyennghia193913@gmail.com', N'Nghia', 0, N'NguyenKhac', N'$2a$12$i8AYxMDqvclGau4oNoFFIOwaozwh6F2gDvCIMUog15FXDINCR0Ypa', N'0123445666', NULL, N'ADMIN', NULL, N'nghia193193')
INSERT [dbo].[users] ([user_id], [address], [avatar], [create_at], [email], [first_name], [is_delete], [last_name], [password], [phone], [reset_password_token], [role], [update_at], [username]) VALUES (16, N'36 Trường chinh Trần Hưng Đạo', N'https://res.cloudinary.com/dmsv3ph70/image/upload/v1671978995/cpsprbosqyhpjvmhi1bz.jpg', CAST(N'2022-12-25' AS Date), N'nguyennghia193913@gmail.com', N'Van', 0, N'Huynh Minh', N'123456', N'0399345678', NULL, N'USER', CAST(N'2022-12-25' AS Date), N'nguyennghia193')
INSERT [dbo].[users] ([user_id], [address], [avatar], [create_at], [email], [first_name], [is_delete], [last_name], [password], [phone], [reset_password_token], [role], [update_at], [username]) VALUES (17, N'Ho Chi Minh City in Viet Nam', N'https://res.cloudinary.com/dmsv3ph70/image/upload/v1672063419/lvemr8i8jr2tbrxr9hkm.jpg', CAST(N'2022-12-26' AS Date), N'20110683@student.hcmute.edu.vn', N'Test', 0, N'Nguyen Khac', N'$2a$12$i8AYxMDqvclGau4oNoFFIOwaozwh6F2gDvCIMUog15FXDINCR0Ypa', N'0123456714', NULL, N'USER', NULL, N'nguyennghia2002')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_r43af9ap4edm43mmtq01oddj6]    Script Date: 8/17/2023 9:10:56 AM ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UK_r43af9ap4edm43mmtq01oddj6] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[books]  WITH CHECK ADD  CONSTRAINT [FKleqa3hhc0uhfvurq6mil47xk0] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([category_id])
GO
ALTER TABLE [dbo].[books] CHECK CONSTRAINT [FKleqa3hhc0uhfvurq6mil47xk0]
GO
ALTER TABLE [dbo].[books]  WITH CHECK ADD  CONSTRAINT [FKqh1naq5iun6n64ayxity5vgit] FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[books] CHECK CONSTRAINT [FKqh1naq5iun6n64ayxity5vgit]
GO
ALTER TABLE [dbo].[cart_items]  WITH CHECK ADD  CONSTRAINT [FKpcttvuq4mxppo8sxggjtn5i2c] FOREIGN KEY([cart_id])
REFERENCES [dbo].[carts] ([cart_id])
GO
ALTER TABLE [dbo].[cart_items] CHECK CONSTRAINT [FKpcttvuq4mxppo8sxggjtn5i2c]
GO
ALTER TABLE [dbo].[cart_items]  WITH CHECK ADD  CONSTRAINT [FKhiu1jw80o45wfiw5tgok1xpkl] FOREIGN KEY([book_id])
REFERENCES [dbo].[books] ([book_id])
GO
ALTER TABLE [dbo].[cart_items] CHECK CONSTRAINT [FKhiu1jw80o45wfiw5tgok1xpkl]
GO
ALTER TABLE [dbo].[carts]  WITH CHECK ADD  CONSTRAINT [FK8brc6ttkleqb6v13w88qi7uor] FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[carts] CHECK CONSTRAINT [FK8brc6ttkleqb6v13w88qi7uor]
GO
ALTER TABLE [dbo].[carts]  WITH CHECK ADD  CONSTRAINT [FKb5o626f86h46m4s7ms6ginnop] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[carts] CHECK CONSTRAINT [FKb5o626f86h46m4s7ms6ginnop]
GO
ALTER TABLE [dbo].[order_items]  WITH CHECK ADD  CONSTRAINT [FKbioxgbv59vetrxe0ejfubep1w] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_items] CHECK CONSTRAINT [FKbioxgbv59vetrxe0ejfubep1w]
GO
ALTER TABLE [dbo].[order_items]  WITH CHECK ADD  CONSTRAINT [FKi4ptndslo2pyfp9r1x0eulh9g] FOREIGN KEY([book_id])
REFERENCES [dbo].[books] ([book_id])
GO
ALTER TABLE [dbo].[order_items] CHECK CONSTRAINT [FKi4ptndslo2pyfp9r1x0eulh9g]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK32ql8ubntj5uh44ph9659tiih] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK32ql8ubntj5uh44ph9659tiih]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FKnqkwhwveegs6ne9ra90y1gq0e] FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FKnqkwhwveegs6ne9ra90y1gq0e]
GO
ALTER TABLE [dbo].[stores]  WITH CHECK ADD  CONSTRAINT [FK62smc31fbgclsu56aa4y2hrxg] FOREIGN KEY([owner_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[stores] CHECK CONSTRAINT [FK62smc31fbgclsu56aa4y2hrxg]
GO
USE [master]
GO
ALTER DATABASE [WebProjectST7] SET  READ_WRITE 
GO
