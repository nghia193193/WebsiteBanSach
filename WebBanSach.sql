USE [master]
GO
/****** Object:  Database [WebProjectST7]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[books]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[cart_items]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[carts]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[categories]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[order_items]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[orders]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[stores]    Script Date: 8/17/2023 8:59:07 AM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 8/17/2023 8:59:07 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_r43af9ap4edm43mmtq01oddj6] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
