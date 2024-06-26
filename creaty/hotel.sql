USE [master]
GO
/****** Object:  Database [Hotel]    Script Date: 31/05/2024 23:21:39 ******/
CREATE DATABASE [Hotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Hotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Hotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Hotel] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hotel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hotel] SET  MULTI_USER 
GO
ALTER DATABASE [Hotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hotel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hotel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hotel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Hotel] SET QUERY_STORE = ON
GO
ALTER DATABASE [Hotel] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Hotel]
GO
/****** Object:  Table [dbo].[pokoje]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pokoje](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_kategoria] [int] NULL,
	[ile_osob] [int] NULL,
	[kwota_za_dobe] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kategorie_pokoju]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kategorie_pokoju](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [nvarchar](255) NULL,
	[czy_balkon] [bit] NULL,
	[czy_aneks] [bit] NULL,
	[czy_klimatyzacja] [bit] NULL,
	[czy_telewizor] [bit] NULL,
	[czy_wanna] [bit] NULL,
	[cena] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[specyfikacja_pokoju]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[specyfikacja_pokoju] AS
SELECT k.nazwa, k.czy_balkon, k.czy_aneks, k.czy_klimatyzacja, k.czy_telewizor, k.czy_wanna, k.cena, p.ile_osob, p.kwota_za_dobe
FROM pokoje as p
INNER JOIN kategorie_pokoju as k on p.id_kategoria = k.id
GO
/****** Object:  Table [dbo].[rezerwacje]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezerwacje](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_klienta] [int] NULL,
	[data_zameldowania] [date] NULL,
	[data_wymeldowania] [date] NULL,
	[data_rezerwacji] [date] NULL,
	[id_status] [int] NULL,
	[rabat] [float] NULL,
 CONSTRAINT [PK_rezerwacje] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rezerwacje_pokoi]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezerwacje_pokoi](
	[id_rezerwacji] [int] NOT NULL,
	[id_pokoju] [int] NOT NULL,
	[cena_pokojow] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[dostepne_pokoje]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[dostepne_pokoje] AS
SELECT p.id, p.id_kategoria, p.ile_osob, p.kwota_za_dobe, k.nazwa, k.czy_balkon, k.czy_aneks, k.czy_klimatyzacja, k.czy_telewizor, k.czy_wanna, rp.id_rezerwacji, rp.id_pokoju, r.data_zameldowania, r.data_wymeldowania, r.id_status
FROM pokoje as p
INNER JOIN kategorie_pokoju as k on p.id_kategoria = k.id
INNER JOIN rezerwacje_pokoi as rp on p.id = rp.id_pokoju
INNER JOIN rezerwacje as r on rp.id_rezerwacji = r.id
WHERE NOT r.id_status = 1;
GO
/****** Object:  Table [dbo].[uslugi]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[uslugi](
	[id_typ_uslugi] [int] NOT NULL,
	[id_rezerwacji] [int] NOT NULL,
	[cena_uslug] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_typ_uslugi] ASC,
	[id_rezerwacji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wyzywienie]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wyzywienie](
	[id_rezerwacji] [int] NOT NULL,
	[id_typ_wyzywienia] [int] NOT NULL,
	[cena_wyzywienia] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[klienci]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[klienci](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[imie] [nvarchar](255) NULL,
	[nazwisko] [nvarchar](255) NULL,
	[telefon] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[statusy]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statusy](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[rezerwacja]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[rezerwacja] AS
SELECT r.id as id_rezerwacji, r.id_klienta, r.data_zameldowania, r.data_wymeldowania, r.data_rezerwacji, r.id_status, r.rabat, k.imie, k.nazwisko, s.nazwa, (u.cena_uslug + rp.cena_pokojow + w.cena_wyzywienia) AS kwota
FROM rezerwacje as r
LEFT JOIN uslugi as u on r.id = u.id_rezerwacji
LEFT JOIN rezerwacje_pokoi as rp on r.id = rp.id_rezerwacji
LEFT JOIN wyzywienie as w on r.id = w.id_rezerwacji
LEFT JOIN klienci as k on r.id_klienta = k.id
LEFT JOIN statusy as s on r.id_status = s.id
GO
/****** Object:  Table [dbo].[typ_uslugi]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[typ_uslugi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[opis] [nvarchar](255) NULL,
	[cena] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[typ_wyzywienia]    Script Date: 31/05/2024 23:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[typ_wyzywienia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[opis] [nvarchar](255) NULL,
	[cena] [money] NULL,
 CONSTRAINT [PK_typ_wyzywienia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[pokoje]  WITH CHECK ADD FOREIGN KEY([id_kategoria])
REFERENCES [dbo].[kategorie_pokoju] ([id])
GO
ALTER TABLE [dbo].[pokoje]  WITH CHECK ADD FOREIGN KEY([id_kategoria])
REFERENCES [dbo].[kategorie_pokoju] ([id])
GO
ALTER TABLE [dbo].[pokoje]  WITH CHECK ADD FOREIGN KEY([id_kategoria])
REFERENCES [dbo].[kategorie_pokoju] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_klienta])
REFERENCES [dbo].[klienci] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_klienta])
REFERENCES [dbo].[klienci] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_klienta])
REFERENCES [dbo].[klienci] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_klienta])
REFERENCES [dbo].[klienci] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_status])
REFERENCES [dbo].[statusy] ([id])
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD FOREIGN KEY([id_status])
REFERENCES [dbo].[statusy] ([id])
GO
ALTER TABLE [dbo].[rezerwacje_pokoi]  WITH CHECK ADD FOREIGN KEY([id_pokoju])
REFERENCES [dbo].[pokoje] ([id])
GO
ALTER TABLE [dbo].[rezerwacje_pokoi]  WITH CHECK ADD FOREIGN KEY([id_pokoju])
REFERENCES [dbo].[pokoje] ([id])
GO
ALTER TABLE [dbo].[rezerwacje_pokoi]  WITH CHECK ADD FOREIGN KEY([id_pokoju])
REFERENCES [dbo].[pokoje] ([id])
GO
ALTER TABLE [dbo].[rezerwacje_pokoi]  WITH CHECK ADD FOREIGN KEY([id_rezerwacji])
REFERENCES [dbo].[rezerwacje] ([id])
GO
ALTER TABLE [dbo].[uslugi]  WITH CHECK ADD FOREIGN KEY([id_rezerwacji])
REFERENCES [dbo].[rezerwacje] ([id])
GO
ALTER TABLE [dbo].[uslugi]  WITH CHECK ADD FOREIGN KEY([id_typ_uslugi])
REFERENCES [dbo].[typ_uslugi] ([id])
GO
ALTER TABLE [dbo].[uslugi]  WITH CHECK ADD FOREIGN KEY([id_typ_uslugi])
REFERENCES [dbo].[typ_uslugi] ([id])
GO
ALTER TABLE [dbo].[uslugi]  WITH CHECK ADD FOREIGN KEY([id_typ_uslugi])
REFERENCES [dbo].[typ_uslugi] ([id])
GO
ALTER TABLE [dbo].[wyzywienie]  WITH CHECK ADD FOREIGN KEY([id_rezerwacji])
REFERENCES [dbo].[rezerwacje] ([id])
GO
ALTER TABLE [dbo].[wyzywienie]  WITH CHECK ADD FOREIGN KEY([id_typ_wyzywienia])
REFERENCES [dbo].[typ_wyzywienia] ([id])
GO
USE [master]
GO
ALTER DATABASE [Hotel] SET  READ_WRITE 
GO
