use master;
drop database WineMarket
GO

CREATE DATABASE WineMarket;
GO

USE WineMarket;
GO

CREATE TABLE [Category] (
  [CategoryId] int identity(1,1) NOT NULL,
  [Name] nvarchar(50) NOT NULL,
  PRIMARY KEY ([CategoryId])
);
GO

CREATE TABLE [Brand] (
  [BrandId] int identity(1,1) NOT NULL,
  [Name] nvarchar(50) NOT NULL,
  [CategoryId] int NOT NULL,
  PRIMARY KEY ([BrandId]),
  CONSTRAINT [FK_Brands.CategoryId]
    FOREIGN KEY ([CategoryId])
      REFERENCES [Category]([CategoryId])
);
GO

CREATE TABLE [User] (
  [UserId] int identity(1,1) NOT NULL,
  [Username] varchar(50) NOT NULL,
  [Password] varchar(100) NOT NULL,
  [Email] varchar(100) NOT NULL,
  [Image] varchar(200) NOT NULL,
  [Role] bit NOT NULL,
  PRIMARY KEY ([UserId])
);
GO

CREATE TABLE [Product] (
  [ProductId] int identity(1,1) NOT NULL,
  [Name] nvarchar(100) NOT NULL,
  [Image] varchar(200) NOT NULL,
  [Price] float NOT NULL,
  [CategoryId] int NOT NULL,
  [BrandId] int NOT NULL,
  PRIMARY KEY ([ProductId]),
  CONSTRAINT [FK_Products.CategoryId]
    FOREIGN KEY ([CategoryId])
      REFERENCES [Category]([CategoryId]),
  CONSTRAINT [FK_Products.BrandId]
    FOREIGN KEY ([BrandId])
      REFERENCES [Brand]([BrandId])
);
GO

CREATE TABLE [Cart] (
  [CartId] int identity(1,1) NOT NULL,
  [UserId] int NOT NULL,
  [ProductId] int NOT NULL,
  [Quantity] int NOT NULL,
  [Hide] bit NOT NULL,
  PRIMARY KEY ([CartId]),
  CONSTRAINT [FK_Cart.UserId]
    FOREIGN KEY ([UserId])
      REFERENCES [User]([UserId]),
  CONSTRAINT [FK_Cart.ProductId]
    FOREIGN KEY ([ProductId])
      REFERENCES [Product]([ProductId])
);
GO

CREATE TABLE [Order] (
	[OrderId] int identity(1,1) NOT NULL,
	[UserId] int NOT NULL,
	[DateOrder] date NOT NULL,
	[Total] float NOT NULL,
	[Status] varchar(20) NOT NULL,
	PRIMARY KEY ([OrderId]),
	CONSTRAINT [FK_Order.UserId]
	  FOREIGN KEY ([UserId])
      REFERENCES [User]([UserId])
);
GO

CREATE TABLE [ContactSupport] (
  [Id] int identity(1,1) NOT NULL,
  [Name] nvarchar(100) NOT NULL,
  [Email] varchar(100) NOT NULL,
  [Subject] varchar(100) NOT NULL,
  [Message] varchar(500) NOT NULL,
  PRIMARY KEY ([Id])
);
GO

CREATE TABLE [ToDo] (
  [Id] int identity(1,1) NOT NULL,
  [Content] nvarchar(100) NOT NULL
  PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Voucher] (
  [Id] varchar(50),
  [Content] nvarchar(100) NOT NULL,
  [Discount] float NOT NULL,
  [Start] date NOT NULL,
  [End] date NOT NULL,
  PRIMARY KEY ([Id])
);
GO


INSERT INTO [Category]([Name]) VALUES
('WHISKY'),
('COGNAC'),
('CHAMPAGNE - VANG'),
('GIN'),
('RUM'),
('TEQUILA'),
('VODKA');
GO

INSERT INTO [Brand]([CategoryId],[Name]) VALUES
(1,'CHIVAS'),
(1,'BALLANTINES'),
(1,'JIM BEAM'),
(1,'JACK DANIELS'),
(2,'HENESSY'),
(2,'CAMUS'),
(2,'MARTELL'),
(3,'G.H MUMM'),
(3,'FRANCE MAISON'),
(3,'DOM PERIGNON'),
(3,'LAROCA'),
(4,'MONKEY 47'),
(4,'GORDON'),
(4,'HENDRICK'),
(4,'TANQUERAY'),
(5,'BACARDI'),
(5,'HAVABA CLUB'),
(5,'CAPTAIN MORGAN'),
(5,'FLOR DE CANA'),
(6,'PATRON'),
(6,'TWO FINGERS'),
(6,'RESERVA 1800'),
(6,'JOSE CUERVO'),
(7,'BELUGA'),
(7,'ABSOLUT'),
(7,'RUSSIAN STANDARD'),
(7,'CIROC');
GO

INSERT INTO [Product]([Name],[Image],[Price],[CategoryId],[BrandId]) VALUES
('CHIVAS ROYAL SALUTE 21','ruou-chivas-21-ava.jpg',220,1,1),
('CHIVAS EXTRA 13','ruou-chivas-extra-13-ava.jpg',75,1,1),
('CHIVAS 18 ULTIMATE CASK COLLECTION','ruou-chivas-18-ultimate-cask-collection-ava.jpg',160,1,1),
('CHIVAS 18 BLUE SIGNATURE','ruou-chivas-18-blue-hop-qua-tet-2022-ava.jpg',170,1,1),
('BALLANTINE’S FINEST','ruou-ballantines-finest-hop-qua-tet-2022-ava.jpg',42,1,2),
('BALLANTINE’S 12','ruou-ballantines-12-ava.jpg',60,1,2),
('BALLANTINE’S 30','ruou-ballantines-30-ava.jpg',550,1,2),
('BALLANTINE’S 17','ruou-ballantines-17-ava.jpg',100,1,2),
('JIM BEAM','ruou-jim-beam-hop-qua-tet-2022-ava.jpg',100,1,3),
('JACK DANIEL’S NO.27 GOLD','ruou-jack-gold-n27-ava.jpg',425,1,4),
('JACK DANIEL’S 3000ML','ruou-jack-daniels-3000ml-ava.jpg',360,1,4),
('JACK DANIEL’S BOTTLED IN BOND','rupu-jack-daniels-bottled-in-bond-1000ml-ava.jpg',150,1,4),
('JACK DANIEL’S SINGLE BARREL','ruou-jack-single-barrel-select-co-hop-ava.jpg',180,1,4),
('HENNESSY XO DELUXE','hennessy-xo-deluxe-hop-qua-tet-2022-ava.jpg',500,2,5),
('HENNESSY VSOP DELUXE','ruou-hennessy-VSOP-deluxe-tet-2021-ava.jpg',150,2,5),
('HENNESSY XO 2019','ruou-Hennessy-XO-2019-ava.jpg',550,2,5),
('HENNESSY XO 2017','ruou-Hennessy-XO-2017-ava.jpg',480,2,5),
('CAMUS XO SUPERIEUR','ruou-Camus-XO-Superieur-ava.jpg',100,2,6),
('CAMUS XO','ruou-Camus-XO-ava.jpg',290,2,6),
('CAMUS VSOP','ruou-Camus-VSOP-ava.jpg',850,2,6),
('CAMUS XO BORDERIES','ruou-Camua-XO-Borderies-ava.jpg',300,2,6),
('MARTELL CORDON BLEU','ruou-martell-cordon-bleu-ava.jpg-1',375,2,7),
('MARTELL XO','ruou-Marrtell-XO-ava.jpg',450,2,7),
('MARTELL VSOP','ruou-Martell-VSOP-ava.jpg',110,2,7),
('MARTELL CORDON BLEU 100','ruou-martell-cordon-bleu-100-ava.jpg',1650,2,7), 
('CHAMPAGNE G.H MUMM ROSE','ruou-gh-mumm-rose-ava.jpg',295,3,8),
('CHAMPAGNE G.H MUMM BLANC DE BLANCE','ruou-vang-gh-mumm-blanc-de-blance-ava.jpg',440,3,8),
('CHAMPAGNE G.H MUMM SILVER','ruou-champagne-gh-mumm-bac-ava.jpg',210,3,8),
('CHAMPAGNE G.H MUMM','ruou-champagne-gh-mumm-ava.jpg',170,3,8),
('VANG FRANCE MAISON CABERNET SAUVIGNON','ruou-vang-france-maison-cabernet-sauvignon-ava.jpg',230,3,9),
('VANG FRANCE MAISON 3L','ruou-vang-France-Maison-3L-ava.jpg',330,3,9),
('WHITE FRANCAISE COMTE TOLOSAN','ruou-vang-Maison-Trang-Francaise-Comte-Tolosan-ava.jpg',150,3,9),
('CHAMPAGNE DOM PERIGNON ROSE','ruou-champagne-dom-perignon-rose-ava.jpg',1000,3,10),
('CHAMPAGNE DOM PERIGNON BLANC','ruou-champagne-dom-perignon-blanc-ava.jpg',530,3,10),
('VANG LAROCA 5L','ruou-vang-bich-chile-la-roca-5-lit-ava.jpg',375,3,11),
('VANG LA ROCA 3L','ruou-vang-bich-chile-la-roca-3-lit-ava.jpg',275,3,11),
('MONKEY 47','ruou-monkey-47-ava.jpg',170,4,12),
('GORDON’S SPECIAL','ruou-gordons-special-gin-ava.jpg',400,4,13),
('GORDON’S ORIGINAL GIN','ruou-gordon-original-gin-ava.jpg',255,4,13),
('HENDRICK’S GIN','ruou-hendricks-gin-ava.jpg',105,4,14),
('TANQUERAY NO TEN','ruou-tanqueray-No-ten-ava.jpg',12,4,15),
('TANQUERAY IMPORTED','ruou-tanqueray-imported-ava.jpg',55,4,15),
('BACARDI RON ANOS 8 YEARS','ruou-bacardi-ron-anos-8y-ava.jpg',75,5,16),
('BACARDI GOLD','ruou-bacardi-gold-ava.jpg',30,5,16),
('BACARDI CARTA NEGRA','ruou-barcadi-carta-negra-ava.jpg',73,5,16),
('BACARDI CARTA BLANCA','ruou-bacardi-carta-blanca-ava.jpg',27.5,5,16),
('HAVANA CLUB UNION','ruou-havana-club-cohiba-union-ava.jpg',700,5,17),
('HAVANA CLUB ANEJO RESERVA','ruou-havana-club-anejo-reserva-ava.jpg',45,5,17),
('HAVANA CLUB ANEJO 7 ANOS','ruou-havana-club-anejo-7-anos-ava.jpg',85,5,17),
('HAVANA CLUB ANEJO 3 ANOS','ruou-havana-club-anejo-3-anos-ava.jpg',35,5,17),
('CAPTAIN MORGAN ORIGINAL SPICED RUM RHUM EPICE','ruou-captain-morgan-original-spiced-rum-rhum-epice-ava.jpg',18,5,18),
('CAPTAIN MORGAN ORIGINAL SPICED GOLD','ruou-captain-morgan-spiced-gold-ava.jpg',28,5,18),
('CAPTAIN MORGAN ORIGINAL RUM','ruou-captain-morgan-original-rum-ava.jpg',37,5,18),
('FLOR DE CANA 5 YEARS ANEJO CLASICO','ruou-flor-de-cana-5-years-anejo-clasico-ava.jpg',40,5,19),
('FLOR DE 4 YEAR CANA EXTRA SECO','ruou-flor-de-cana-4-years-extra-seco-ava.jpg',55,5,19),
('PATRON XO CAFE','ruou-patron-xo-cafe-ava.jpg',95,6,20),
('PATRON SILVER','ruou-patron-silver-ava.jpg',145,6,20),
('PATRON ANEJO','ruou-patron-anejo-ava.jpg',200,6,20),
('PATRON REPOSADO','ruou-patron-reposado-ava.jpg',140,6,20),
('TWO FINGERS SILVER TEQUILA','ruou-two-fingers-silver-tequilla-ava.jpg',35,6,21),
('TWO FINGERS GOLD TEQUILA','ruou-two-fingers-gold-tequila-ava.jpg',30,6,21),
('TEQUILA RESERVA 1800 REPOSADO','ruou-tequila-reserva-1800-reposado-ava.jpg',140,6,22),
('TEQUILA RESERVA 1800 SILVER','ruou-tequila-1800-silver-ava.jpg',135,6,22),
('JOSE CUERVO ESPECIALE GOLD','ruou-jose-cuervo-especiale-gold-vang-ava.jpg',35,6,23),
('BELUGA ALLURE VODKA','ruou-Beluga-Allure-Vodka-ava.jpg',240,7,24),
('BELUGA GOLD LINE VODKA','ruou-Beluga-Gold-Line-vodka-ava.jpg',210,7,24),
('BELUGA NOBLE CELEBRATION','ruou-beluga-noble-celebration-vang-ava.jpg',85,7,24),
('BELUGA TRANSATLANTIC','ruou-beluga-transatlantic-ava.jpg',105,7,24),
('ABSOLUT ELYX VODKA','ruou-absolut-elyx-vodka-ava.jpg',165,7,25),
('ABSOLUT VANILIA VODKA','ruou-absolut-vanilia-vodka-ava.jpg',40,7,25),
('ABSOLUT RUBY RED VODKA','ruou-absolut-ruby-red-ava.jpg',40,7,25),
('ABSOLUT RASPBERRI VODKA','ruou-absolut-raspberri-vodka-dau-ava.jpg',40,7,25),
('STANDARD VODKA','ruou-standard-vodka-ava.jpg',35,7,26),
('STANDARD IMPERIAL VODKA','ruou-Standard-Imperial-Vodka-ava.jpg',135,7,26),
('STANDARD GOLD VODKA','ruou-standard-gold-ava.jpg',45,7,26),
('CIROC COCONUT VODKA','ruou-ciroc-coconut-ava.jpg',125,7,27),
('CIROC PINEAPPLE','ruou-ciroc-pineapple-ava.jpg',125,7,27),
('CIROC RED BERRY','ruou-ciroc-red-berry-ava.jpg',125,7,27),
('CIROC VODKA','ruou-ciroc-vodka-ava.jpg',125,7,27);
GO

SET IDENTITY_INSERT [User] OFF
GO

INSERT INTO [User]([Username],[Password],[Email],[Image],[Role]) VALUES
('user','202cb962ac59075b964b07152d234b70','nghiaplps17855@fpt.edu.vn','null.png',0),
('admin','202cb962ac59075b964b07152d234b70','nghiaplps17855@fpt.edu.vn','null.png',1);
GO

INSERT INTO [ContactSupport]([Name],[Email],[Subject],[Message]) VALUES
('TEST','nghiaplps17855@fpt.edu.vn','HELP ME','KO CO J');
GO

INSERT INTO [ToDo]([Content]) VALUES
('HEYYYYYYYYYY');
GO

INSERT INTO [Voucher] ([Id],[Content],[Discount],[Start],[End]) VALUES
('MUNG83','Happy women day',20,'2022-03-01 00:00:00','2022-03-15 23:59:59'),
('MUNGXUAN','Happy new year',20,'2022-01-01 00:00:00','2022-01-15 23:59:59'),
('TETTHIEUNHI','International Children',20,'2022-06-01 00:00:00','2022-06-30 23:59:59');

