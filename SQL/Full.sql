USE [PROG260FA22]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PokemonFull'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PokemonFull'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullStats'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullStats'
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPokemon]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_InsertPokemon]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTypeChartData]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_GetTypeChartData]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGenerationChartData]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_GetGenerationChartData]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllTypes]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_GetAllTypes]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllRegions]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_GetAllRegions]
GO
/****** Object:  StoredProcedure [dbo].[sp_FilteredPokemon]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP PROCEDURE [dbo].[sp_FilteredPokemon]
GO
ALTER TABLE [dbo].[PokemonStatistic] DROP CONSTRAINT [FK_Type2_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic] DROP CONSTRAINT [FK_Type1_ID]
GO
ALTER TABLE [dbo].[Pokemon] DROP CONSTRAINT [FK_Stats_ID]
GO
ALTER TABLE [dbo].[Pokemon] DROP CONSTRAINT [FK_Generation_ID]
GO
/****** Object:  View [dbo].[vw_PokemonFull]    Script Date: 12/12/2022 11:07:39 AM ******/
DROP VIEW [dbo].[vw_PokemonFull]
GO
/****** Object:  Table [dbo].[Pokemon]    Script Date: 12/12/2022 11:07:39 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pokemon]') AND type in (N'U'))
DROP TABLE [dbo].[Pokemon]
GO
/****** Object:  Table [dbo].[Generation]    Script Date: 12/12/2022 11:07:40 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Generation]') AND type in (N'U'))
DROP TABLE [dbo].[Generation]
GO
/****** Object:  View [dbo].[vw_FullStats]    Script Date: 12/12/2022 11:07:40 AM ******/
DROP VIEW [dbo].[vw_FullStats]
GO
/****** Object:  Table [dbo].[PokemonStatistic]    Script Date: 12/12/2022 11:07:40 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PokemonStatistic]') AND type in (N'U'))
DROP TABLE [dbo].[PokemonStatistic]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/12/2022 11:07:40 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Type]') AND type in (N'U'))
DROP TABLE [dbo].[Type]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[HexColor] [nvarchar](50) NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PokemonStatistic]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PokemonStatistic](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type1_ID] [int] NOT NULL,
	[Type2_ID] [int] NULL,
	[HP] [int] NOT NULL,
	[Attack] [int] NOT NULL,
	[Defense] [int] NOT NULL,
	[Sp_Atk] [int] NOT NULL,
	[Sp_Def] [int] NOT NULL,
	[Speed] [int] NOT NULL,
 CONSTRAINT [PK_PokemonStatistic] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FullStats]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_FullStats]
AS
SELECT        a.ID, b.Name AS Type_1, c.Name AS Type_2, a.HP, a.Attack, a.Defense, a.Sp_Atk, a.Sp_Def, a.Speed
FROM            dbo.PokemonStatistic AS a INNER JOIN
                         dbo.Type AS b ON a.Type1_ID = b.ID FULL OUTER JOIN
                         dbo.Type AS c ON a.Type2_ID = c.ID
GO
/****** Object:  Table [dbo].[Generation]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Generation_Number] [int] NOT NULL,
	[Region_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Generation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pokemon]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pokemon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Pokedex_Number] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Stats_ID] [int] NOT NULL,
	[Generation_ID] [int] NOT NULL,
 CONSTRAINT [PK_Pokemon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_PokemonFull]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_PokemonFull]
AS
SELECT        a.ID, a.Pokedex_Number, a.Name, b.Type_1, b.Type_2, b.HP, b.Attack, b.Defense, b.Sp_Atk, b.Sp_Def, b.Speed, c.Generation_Number, c.Region_Name
FROM            dbo.Pokemon AS a INNER JOIN
                         dbo.vw_FullStats AS b ON a.Stats_ID = b.ID INNER JOIN
                         dbo.Generation AS c ON a.Generation_ID = c.ID
GO
SET IDENTITY_INSERT [dbo].[Generation] ON 

INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (1, 1, N'Kanto')
INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (2, 2, N'Johto')
INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (3, 3, N'Hoenn')
INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (4, 4, N'Sinnoh')
INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (5, 5, N'Unova')
INSERT [dbo].[Generation] ([ID], [Generation_Number], [Region_Name]) VALUES (6, 6, N'Kalos')
SET IDENTITY_INSERT [dbo].[Generation] OFF
GO
SET IDENTITY_INSERT [dbo].[Pokemon] ON 

INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (1, 1, N'Bulbasaur', 1, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (2, 2, N'Ivysaur', 2, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (3, 3, N'Venusaur', 3, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (4, 3, N'Mega Venusaur', 4, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (5, 4, N'Charmander', 5, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (6, 5, N'Charmeleon', 6, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (7, 6, N'Charizard', 7, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (8, 6, N'Mega Charizard X', 8, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (9, 6, N'Mega Charizard Y', 9, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (10, 7, N'Squirtle', 10, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (11, 8, N'Wartortle', 11, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (12, 9, N'Blastoise', 12, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (13, 9, N'Mega Blastoise', 13, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (14, 10, N'Caterpie', 14, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (15, 11, N'Metapod', 15, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (16, 12, N'Butterfree', 16, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (17, 13, N'Weedle', 17, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (18, 14, N'Kakuna', 18, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (19, 15, N'Beedrill', 19, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (20, 15, N'Mega Beedrill', 20, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (21, 16, N'Pidgey', 21, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (22, 17, N'Pidgeotto', 22, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (23, 18, N'Pidgeot', 23, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (24, 18, N'Mega Pidgeot', 24, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (25, 19, N'Rattata', 25, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (26, 20, N'Raticate', 26, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (27, 21, N'Spearow', 27, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (28, 22, N'Fearow', 28, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (29, 23, N'Ekans', 29, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (30, 24, N'Arbok', 30, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (31, 25, N'Pikachu', 31, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (32, 26, N'Raichu', 32, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (33, 27, N'Sandshrew', 33, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (34, 28, N'Sandslash', 34, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (35, 29, N'Nidoran♀', 35, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (36, 30, N'Nidorina', 36, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (37, 31, N'Nidoqueen', 37, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (38, 32, N'Nidoran♂', 38, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (39, 33, N'Nidorino', 39, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (40, 34, N'Nidoking', 40, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (41, 35, N'Clefairy', 41, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (42, 36, N'Clefable', 42, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (43, 37, N'Vulpix', 43, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (44, 38, N'Ninetales', 44, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (45, 39, N'Jigglypuff', 45, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (46, 40, N'Wigglytuff', 46, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (47, 41, N'Zubat', 47, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (48, 42, N'Golbat', 48, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (49, 43, N'Oddish', 49, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (50, 44, N'Gloom', 50, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (51, 45, N'Vileplume', 51, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (52, 46, N'Paras', 52, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (53, 47, N'Parasect', 53, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (54, 48, N'Venonat', 54, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (55, 49, N'Venomoth', 55, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (56, 50, N'Diglett', 56, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (57, 51, N'Dugtrio', 57, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (58, 52, N'Meowth', 58, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (59, 53, N'Persian', 59, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (60, 54, N'Psyduck', 60, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (61, 55, N'Golduck', 61, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (62, 56, N'Mankey', 62, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (63, 57, N'Primeape', 63, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (64, 58, N'Growlithe', 64, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (65, 59, N'Arcanine', 65, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (66, 60, N'Poliwag', 66, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (67, 61, N'Poliwhirl', 67, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (68, 62, N'Poliwrath', 68, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (69, 63, N'Abra', 69, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (70, 64, N'Kadabra', 70, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (71, 65, N'Alakazam', 71, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (72, 65, N'Mega Alakazam', 72, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (73, 66, N'Machop', 73, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (74, 67, N'Machoke', 74, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (75, 68, N'Machamp', 75, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (76, 69, N'Bellsprout', 76, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (77, 70, N'Weepinbell', 77, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (78, 71, N'Victreebel', 78, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (79, 72, N'Tentacool', 79, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (80, 73, N'Tentacruel', 80, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (81, 74, N'Geodude', 81, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (82, 75, N'Graveler', 82, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (83, 76, N'Golem', 83, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (84, 77, N'Ponyta', 84, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (85, 78, N'Rapidash', 85, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (86, 79, N'Slowpoke', 86, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (87, 80, N'Slowbro', 87, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (88, 80, N'Mega Slowbro', 88, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (89, 81, N'Magnemite', 89, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (90, 82, N'Magneton', 90, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (91, 83, N'Farfetch''d', 91, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (92, 84, N'Doduo', 92, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (93, 85, N'Dodrio', 93, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (94, 86, N'Seel', 94, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (95, 87, N'Dewgong', 95, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (96, 88, N'Grimer', 96, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (97, 89, N'Muk', 97, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (98, 90, N'Shellder', 98, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (99, 91, N'Cloyster', 99, 1)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (100, 92, N'Gastly', 100, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (101, 93, N'Haunter', 101, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (102, 94, N'Gengar', 102, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (103, 94, N'Mega Gengar', 103, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (104, 95, N'Onix', 104, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (105, 96, N'Drowzee', 105, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (106, 97, N'Hypno', 106, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (107, 98, N'Krabby', 107, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (108, 99, N'Kingler', 108, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (109, 100, N'Voltorb', 109, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (110, 101, N'Electrode', 110, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (111, 102, N'Exeggcute', 111, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (112, 103, N'Exeggutor', 112, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (113, 104, N'Cubone', 113, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (114, 105, N'Marowak', 114, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (115, 106, N'Hitmonlee', 115, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (116, 107, N'Hitmonchan', 116, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (117, 108, N'Lickitung', 117, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (118, 109, N'Koffing', 118, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (119, 110, N'Weezing', 119, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (120, 111, N'Rhyhorn', 120, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (121, 112, N'Rhydon', 121, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (122, 113, N'Chansey', 122, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (123, 114, N'Tangela', 123, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (124, 115, N'Kangaskhan', 124, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (125, 115, N'Mega Kangaskhan', 125, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (126, 116, N'Horsea', 126, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (127, 117, N'Seadra', 127, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (128, 118, N'Goldeen', 128, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (129, 119, N'Seaking', 129, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (130, 120, N'Staryu', 130, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (131, 121, N'Starmie', 131, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (132, 122, N'Mr. Mime', 132, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (133, 123, N'Scyther', 133, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (134, 124, N'Jynx', 134, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (135, 125, N'Electabuzz', 135, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (136, 126, N'Magmar', 136, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (137, 127, N'Pinsir', 137, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (138, 127, N'Mega Pinsir', 138, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (139, 128, N'Tauros', 139, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (140, 129, N'Magikarp', 140, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (141, 130, N'Gyarados', 141, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (142, 130, N'Mega Gyarados', 142, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (143, 131, N'Lapras', 143, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (144, 132, N'Ditto', 144, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (145, 133, N'Eevee', 145, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (146, 134, N'Vaporeon', 146, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (147, 135, N'Jolteon', 147, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (148, 136, N'Flareon', 148, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (149, 137, N'Porygon', 149, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (150, 138, N'Omanyte', 150, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (151, 139, N'Omastar', 151, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (152, 140, N'Kabuto', 152, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (153, 141, N'Kabutops', 153, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (154, 142, N'Aerodactyl', 154, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (155, 142, N'Mega Aerodactyl', 155, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (156, 143, N'Snorlax', 156, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (157, 144, N'Articuno', 157, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (158, 145, N'Zapdos', 158, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (159, 146, N'Moltres', 159, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (160, 147, N'Dratini', 160, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (161, 148, N'Dragonair', 161, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (162, 149, N'Dragonite', 162, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (163, 150, N'Mewtwo', 163, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (164, 150, N'Mega Mewtwo X', 164, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (165, 150, N'Mega Mewtwo Y', 165, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (166, 151, N'Mew', 166, 1)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (167, 152, N'Chikorita', 167, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (168, 153, N'Bayleef', 168, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (169, 154, N'Meganium', 169, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (170, 155, N'Cyndaquil', 170, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (171, 156, N'Quilava', 171, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (172, 157, N'Typhlosion', 172, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (173, 158, N'Totodile', 173, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (174, 159, N'Croconaw', 174, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (175, 160, N'Feraligatr', 175, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (176, 161, N'Sentret', 176, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (177, 162, N'Furret', 177, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (178, 163, N'Hoothoot', 178, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (179, 164, N'Noctowl', 179, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (180, 165, N'Ledyba', 180, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (181, 166, N'Ledian', 181, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (182, 167, N'Spinarak', 182, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (183, 168, N'Ariados', 183, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (184, 169, N'Crobat', 184, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (185, 170, N'Chinchou', 185, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (186, 171, N'Lanturn', 186, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (187, 172, N'Pichu', 187, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (188, 173, N'Cleffa', 188, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (189, 174, N'Igglybuff', 189, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (190, 175, N'Togepi', 190, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (191, 176, N'Togetic', 191, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (192, 177, N'Natu', 192, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (193, 178, N'Xatu', 193, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (194, 179, N'Mareep', 194, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (195, 180, N'Flaaffy', 195, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (196, 181, N'Ampharos', 196, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (197, 181, N'Mega Ampharos', 197, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (198, 182, N'Bellossom', 198, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (199, 183, N'Marill', 199, 2)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (200, 184, N'Azumarill', 200, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (201, 185, N'Sudowoodo', 201, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (202, 186, N'Politoed', 202, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (203, 187, N'Hoppip', 203, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (204, 188, N'Skiploom', 204, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (205, 189, N'Jumpluff', 205, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (206, 190, N'Aipom', 206, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (207, 191, N'Sunkern', 207, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (208, 192, N'Sunflora', 208, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (209, 193, N'Yanma', 209, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (210, 194, N'Wooper', 210, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (211, 195, N'Quagsire', 211, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (212, 196, N'Espeon', 212, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (213, 197, N'Umbreon', 213, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (214, 198, N'Murkrow', 214, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (215, 199, N'Slowking', 215, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (216, 200, N'Misdreavus', 216, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (217, 201, N'Unown', 217, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (218, 202, N'Wobbuffet', 218, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (219, 203, N'Girafarig', 219, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (220, 204, N'Pineco', 220, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (221, 205, N'Forretress', 221, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (222, 206, N'Dunsparce', 222, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (223, 207, N'Gligar', 223, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (224, 208, N'Steelix', 224, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (225, 208, N'Mega Steelix', 225, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (226, 209, N'Snubbull', 226, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (227, 210, N'Granbull', 227, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (228, 211, N'Qwilfish', 228, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (229, 212, N'Scizor', 229, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (230, 212, N'Mega Scizor', 230, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (231, 213, N'Shuckle', 231, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (232, 214, N'Heracross', 232, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (233, 214, N'Mega Heracross', 233, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (234, 215, N'Sneasel', 234, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (235, 216, N'Teddiursa', 235, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (236, 217, N'Ursaring', 236, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (237, 218, N'Slugma', 237, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (238, 219, N'Magcargo', 238, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (239, 220, N'Swinub', 239, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (240, 221, N'Piloswine', 240, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (241, 222, N'Corsola', 241, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (242, 223, N'Remoraid', 242, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (243, 224, N'Octillery', 243, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (244, 225, N'Delibird', 244, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (245, 226, N'Mantine', 245, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (246, 227, N'Skarmory', 246, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (247, 228, N'Houndour', 247, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (248, 229, N'Houndoom', 248, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (249, 229, N'Mega Houndoom', 249, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (250, 230, N'Kingdra', 250, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (251, 231, N'Phanpy', 251, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (252, 232, N'Donphan', 252, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (253, 233, N'Porygon2', 253, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (254, 234, N'Stantler', 254, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (255, 235, N'Smeargle', 255, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (256, 236, N'Tyrogue', 256, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (257, 237, N'Hitmontop', 257, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (258, 238, N'Smoochum', 258, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (259, 239, N'Elekid', 259, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (260, 240, N'Magby', 260, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (261, 241, N'Miltank', 261, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (262, 242, N'Blissey', 262, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (263, 243, N'Raikou', 263, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (264, 244, N'Entei', 264, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (265, 245, N'Suicune', 265, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (266, 246, N'Larvitar', 266, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (267, 247, N'Pupitar', 267, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (268, 248, N'Tyranitar', 268, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (269, 248, N'Mega Tyranitar', 269, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (270, 249, N'Lugia', 270, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (271, 250, N'Ho-oh', 271, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (272, 251, N'Celebi', 272, 2)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (273, 252, N'Treecko', 273, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (274, 253, N'Grovyle', 274, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (275, 254, N'Sceptile', 275, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (276, 254, N'Mega Sceptile', 276, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (277, 255, N'Torchic', 277, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (278, 256, N'Combusken', 278, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (279, 257, N'Blaziken', 279, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (280, 257, N'Mega Blaziken', 280, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (281, 258, N'Mudkip', 281, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (282, 259, N'Marshtomp', 282, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (283, 260, N'Swampert', 283, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (284, 260, N'Mega Swampert', 284, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (285, 261, N'Poochyena', 285, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (286, 262, N'Mightyena', 286, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (287, 263, N'Zigzagoon', 287, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (288, 264, N'Linoone', 288, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (289, 265, N'Wurmple', 289, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (290, 266, N'Silcoon', 290, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (291, 267, N'Beautifly', 291, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (292, 268, N'Cascoon', 292, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (293, 269, N'Dustox', 293, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (294, 270, N'Lotad', 294, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (295, 271, N'Lombre', 295, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (296, 272, N'Ludicolo', 296, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (297, 273, N'Seedot', 297, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (298, 274, N'Nuzleaf', 298, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (299, 275, N'Shiftry', 299, 3)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (300, 276, N'Taillow', 300, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (301, 277, N'Swellow', 301, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (302, 278, N'Wingull', 302, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (303, 279, N'Pelipper', 303, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (304, 280, N'Ralts', 304, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (305, 281, N'Kirlia', 305, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (306, 282, N'Gardevoir', 306, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (307, 282, N'Mega Gardevoir', 307, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (308, 283, N'Surskit', 308, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (309, 284, N'Masquerain', 309, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (310, 285, N'Shroomish', 310, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (311, 286, N'Breloom', 311, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (312, 287, N'Slakoth', 312, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (313, 288, N'Vigoroth', 313, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (314, 289, N'Slaking', 314, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (315, 290, N'Nincada', 315, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (316, 291, N'Ninjask', 316, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (317, 292, N'Shedinja', 317, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (318, 293, N'Whismur', 318, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (319, 294, N'Loudred', 319, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (320, 295, N'Exploud', 320, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (321, 296, N'Makuhita', 321, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (322, 297, N'Hariyama', 322, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (323, 298, N'Azurill', 323, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (324, 299, N'Nosepass', 324, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (325, 300, N'Skitty', 325, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (326, 301, N'Delcatty', 326, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (327, 302, N'Sableye', 327, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (328, 302, N'Mega Sableye', 328, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (329, 303, N'Mawile', 329, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (330, 303, N'Mega Mawile', 330, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (331, 304, N'Aron', 331, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (332, 305, N'Lairon', 332, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (333, 306, N'Aggron', 333, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (334, 306, N'Mega Aggron', 334, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (335, 307, N'Meditite', 335, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (336, 308, N'Medicham', 336, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (337, 308, N'Mega Medicham', 337, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (338, 309, N'Electrike', 338, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (339, 310, N'Manectric', 339, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (340, 310, N'Mega Manectric', 340, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (341, 311, N'Plusle', 341, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (342, 312, N'Minun', 342, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (343, 313, N'Volbeat', 343, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (344, 314, N'Illumise', 344, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (345, 315, N'Roselia', 345, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (346, 316, N'Gulpin', 346, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (347, 317, N'Swalot', 347, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (348, 318, N'Carvanha', 348, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (349, 319, N'Sharpedo', 349, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (350, 319, N'Mega Sharpedo', 350, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (351, 320, N'Wailmer', 351, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (352, 321, N'Wailord', 352, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (353, 322, N'Numel', 353, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (354, 323, N'Camerupt', 354, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (355, 323, N'Mega Camerupt', 355, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (356, 324, N'Torkoal', 356, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (357, 325, N'Spoink', 357, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (358, 326, N'Grumpig', 358, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (359, 327, N'Spinda', 359, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (360, 328, N'Trapinch', 360, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (361, 329, N'Vibrava', 361, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (362, 330, N'Flygon', 362, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (363, 331, N'Cacnea', 363, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (364, 332, N'Cacturne', 364, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (365, 333, N'Swablu', 365, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (366, 334, N'Altaria', 366, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (367, 334, N'Mega Altaria', 367, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (368, 335, N'Zangoose', 368, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (369, 336, N'Seviper', 369, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (370, 337, N'Lunatone', 370, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (371, 338, N'Solrock', 371, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (372, 339, N'Barboach', 372, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (373, 340, N'Whiscash', 373, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (374, 341, N'Corphish', 374, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (375, 342, N'Crawdaunt', 375, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (376, 343, N'Baltoy', 376, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (377, 344, N'Claydol', 377, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (378, 345, N'Lileep', 378, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (379, 346, N'Cradily', 379, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (380, 347, N'Anorith', 380, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (381, 348, N'Armaldo', 381, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (382, 349, N'Feebas', 382, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (383, 350, N'Milotic', 383, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (384, 351, N'Castform', 384, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (385, 352, N'Kecleon', 385, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (386, 353, N'Shuppet', 386, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (387, 354, N'Banette', 387, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (388, 354, N'Mega Banette', 388, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (389, 355, N'Duskull', 389, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (390, 356, N'Dusclops', 390, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (391, 357, N'Tropius', 391, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (392, 358, N'Chimecho', 392, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (393, 359, N'Absol', 393, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (394, 359, N'Mega Absol', 394, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (395, 360, N'Wynaut', 395, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (396, 361, N'Snorunt', 396, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (397, 362, N'Glalie', 397, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (398, 362, N'Mega Glalie', 398, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (399, 363, N'Spheal', 399, 3)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (400, 364, N'Sealeo', 400, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (401, 365, N'Walrein', 401, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (402, 366, N'Clamperl', 402, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (403, 367, N'Huntail', 403, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (404, 368, N'Gorebyss', 404, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (405, 369, N'Relicanth', 405, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (406, 370, N'Luvdisc', 406, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (407, 371, N'Bagon', 407, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (408, 372, N'Shelgon', 408, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (409, 373, N'Salamence', 409, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (410, 373, N'Mega Salamence', 410, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (411, 374, N'Beldum', 411, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (412, 375, N'Metang', 412, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (413, 376, N'Metagross', 413, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (414, 376, N'Mega Metagross', 414, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (415, 377, N'Regirock', 415, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (416, 378, N'Regice', 416, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (417, 379, N'Registeel', 417, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (418, 380, N'Latias', 418, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (419, 380, N'Mega Latias', 419, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (420, 381, N'Latios', 420, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (421, 381, N'Mega Latios', 421, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (422, 382, N'Kyogre', 422, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (423, 382, N'Primal Kyogre', 423, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (424, 383, N'Groudon', 424, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (425, 383, N'Primal Groudon', 425, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (426, 384, N'Rayquaza', 426, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (427, 384, N'Mega Rayquaza', 427, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (428, 385, N'Jirachi', 428, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (429, 386, N'Deoxys Normal Forme', 429, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (430, 386, N'Deoxys Attack Forme', 430, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (431, 386, N'Deoxys Defense Forme', 431, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (432, 386, N'Deoxys Speed Forme', 432, 3)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (433, 387, N'Turtwig', 433, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (434, 388, N'Grotle', 434, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (435, 389, N'Torterra', 435, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (436, 390, N'Chimchar', 436, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (437, 391, N'Monferno', 437, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (438, 392, N'Infernape', 438, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (439, 393, N'Piplup', 439, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (440, 394, N'Prinplup', 440, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (441, 395, N'Empoleon', 441, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (442, 396, N'Starly', 442, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (443, 397, N'Staravia', 443, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (444, 398, N'Staraptor', 444, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (445, 399, N'Bidoof', 445, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (446, 400, N'Bibarel', 446, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (447, 401, N'Kricketot', 447, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (448, 402, N'Kricketune', 448, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (449, 403, N'Shinx', 449, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (450, 404, N'Luxio', 450, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (451, 405, N'Luxray', 451, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (452, 406, N'Budew', 452, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (453, 407, N'Roserade', 453, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (454, 408, N'Cranidos', 454, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (455, 409, N'Rampardos', 455, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (456, 410, N'Shieldon', 456, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (457, 411, N'Bastiodon', 457, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (458, 412, N'Burmy', 458, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (459, 413, N'Wormadam Plant Cloak', 459, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (460, 413, N'Wormadam Sandy Cloak', 460, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (461, 413, N'Wormadam Trash Cloak', 461, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (462, 414, N'Mothim', 462, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (463, 415, N'Combee', 463, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (464, 416, N'Vespiquen', 464, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (465, 417, N'Pachirisu', 465, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (466, 418, N'Buizel', 466, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (467, 419, N'Floatzel', 467, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (468, 420, N'Cherubi', 468, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (469, 421, N'Cherrim', 469, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (470, 422, N'Shellos', 470, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (471, 423, N'Gastrodon', 471, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (472, 424, N'Ambipom', 472, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (473, 425, N'Drifloon', 473, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (474, 426, N'Drifblim', 474, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (475, 427, N'Buneary', 475, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (476, 428, N'Lopunny', 476, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (477, 428, N'Mega Lopunny', 477, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (478, 429, N'Mismagius', 478, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (479, 430, N'Honchkrow', 479, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (480, 431, N'Glameow', 480, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (481, 432, N'Purugly', 481, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (482, 433, N'Chingling', 482, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (483, 434, N'Stunky', 483, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (484, 435, N'Skuntank', 484, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (485, 436, N'Bronzor', 485, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (486, 437, N'Bronzong', 486, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (487, 438, N'Bonsly', 487, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (488, 439, N'Mime Jr.', 488, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (489, 440, N'Happiny', 489, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (490, 441, N'Chatot', 490, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (491, 442, N'Spiritomb', 491, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (492, 443, N'Gible', 492, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (493, 444, N'Gabite', 493, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (494, 445, N'Garchomp', 494, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (495, 445, N'Mega Garchomp', 495, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (496, 446, N'Munchlax', 496, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (497, 447, N'Riolu', 497, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (498, 448, N'Lucario', 498, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (499, 448, N'Mega Lucario', 499, 4)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (500, 449, N'Hippopotas', 500, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (501, 450, N'Hippowdon', 501, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (502, 451, N'Skorupi', 502, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (503, 452, N'Drapion', 503, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (504, 453, N'Croagunk', 504, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (505, 454, N'Toxicroak', 505, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (506, 455, N'Carnivine', 506, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (507, 456, N'Finneon', 507, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (508, 457, N'Lumineon', 508, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (509, 458, N'Mantyke', 509, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (510, 459, N'Snover', 510, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (511, 460, N'Abomasnow', 511, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (512, 460, N'Mega Abomasnow', 512, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (513, 461, N'Weavile', 513, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (514, 462, N'Magnezone', 514, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (515, 463, N'Lickilicky', 515, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (516, 464, N'Rhyperior', 516, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (517, 465, N'Tangrowth', 517, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (518, 466, N'Electivire', 518, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (519, 467, N'Magmortar', 519, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (520, 468, N'Togekiss', 520, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (521, 469, N'Yanmega', 521, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (522, 470, N'Leafeon', 522, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (523, 471, N'Glaceon', 523, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (524, 472, N'Gliscor', 524, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (525, 473, N'Mamoswine', 525, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (526, 474, N'Porygon-Z', 526, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (527, 475, N'Gallade', 527, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (528, 475, N'Mega Gallade', 528, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (529, 476, N'Probopass', 529, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (530, 477, N'Dusknoir', 530, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (531, 478, N'Froslass', 531, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (532, 479, N'Rotom', 532, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (533, 479, N'RotomHeat', 533, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (534, 479, N'RotomWash', 534, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (535, 479, N'RotomFrost', 535, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (536, 479, N'RotomFan', 536, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (537, 479, N'RotomMow', 537, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (538, 480, N'Uxie', 538, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (539, 481, N'Mesprit', 539, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (540, 482, N'Azelf', 540, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (541, 483, N'Dialga', 541, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (542, 484, N'Palkia', 542, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (543, 485, N'Heatran', 543, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (544, 486, N'Regigigas', 544, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (545, 487, N'Giratina Altered Forme', 545, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (546, 487, N'Giratina Origin Forme', 546, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (547, 488, N'Cresselia', 547, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (548, 489, N'Phione', 548, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (549, 490, N'Manaphy', 549, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (550, 491, N'Darkrai', 550, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (551, 492, N'Shaymin Land Forme', 551, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (552, 492, N'Shaymin Sky Forme', 552, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (553, 493, N'Arceus', 553, 4)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (554, 494, N'Victini', 554, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (555, 495, N'Snivy', 555, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (556, 496, N'Servine', 556, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (557, 497, N'Serperior', 557, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (558, 498, N'Tepig', 558, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (559, 499, N'Pignite', 559, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (560, 500, N'Emboar', 560, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (561, 501, N'Oshawott', 561, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (562, 502, N'Dewott', 562, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (563, 503, N'Samurott', 563, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (564, 504, N'Patrat', 564, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (565, 505, N'Watchog', 565, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (566, 506, N'Lillipup', 566, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (567, 507, N'Herdier', 567, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (568, 508, N'Stoutland', 568, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (569, 509, N'Purrloin', 569, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (570, 510, N'Liepard', 570, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (571, 511, N'Pansage', 571, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (572, 512, N'Simisage', 572, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (573, 513, N'Pansear', 573, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (574, 514, N'Simisear', 574, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (575, 515, N'Panpour', 575, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (576, 516, N'Simipour', 576, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (577, 517, N'Munna', 577, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (578, 518, N'Musharna', 578, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (579, 519, N'Pidove', 579, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (580, 520, N'Tranquill', 580, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (581, 521, N'Unfezant', 581, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (582, 522, N'Blitzle', 582, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (583, 523, N'Zebstrika', 583, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (584, 524, N'Roggenrola', 584, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (585, 525, N'Boldore', 585, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (586, 526, N'Gigalith', 586, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (587, 527, N'Woobat', 587, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (588, 528, N'Swoobat', 588, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (589, 529, N'Drilbur', 589, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (590, 530, N'Excadrill', 590, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (591, 531, N'Audino', 591, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (592, 531, N'Mega Audino', 592, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (593, 532, N'Timburr', 593, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (594, 533, N'Gurdurr', 594, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (595, 534, N'Conkeldurr', 595, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (596, 535, N'Tympole', 596, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (597, 536, N'Palpitoad', 597, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (598, 537, N'Seismitoad', 598, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (599, 538, N'Throh', 599, 5)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (600, 539, N'Sawk', 600, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (601, 540, N'Sewaddle', 601, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (602, 541, N'Swadloon', 602, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (603, 542, N'Leavanny', 603, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (604, 543, N'Venipede', 604, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (605, 544, N'Whirlipede', 605, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (606, 545, N'Scolipede', 606, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (607, 546, N'Cottonee', 607, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (608, 547, N'Whimsicott', 608, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (609, 548, N'Petilil', 609, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (610, 549, N'Lilligant', 610, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (611, 550, N'Basculin', 611, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (612, 551, N'Sandile', 612, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (613, 552, N'Krokorok', 613, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (614, 553, N'Krookodile', 614, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (615, 554, N'Darumaka', 615, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (616, 555, N'Darmanitan Standard Mode', 616, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (617, 555, N'Darmanitan Zen Mode', 617, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (618, 556, N'Maractus', 618, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (619, 557, N'Dwebble', 619, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (620, 558, N'Crustle', 620, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (621, 559, N'Scraggy', 621, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (622, 560, N'Scrafty', 622, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (623, 561, N'Sigilyph', 623, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (624, 562, N'Yamask', 624, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (625, 563, N'Cofagrigus', 625, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (626, 564, N'Tirtouga', 626, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (627, 565, N'Carracosta', 627, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (628, 566, N'Archen', 628, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (629, 567, N'Archeops', 629, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (630, 568, N'Trubbish', 630, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (631, 569, N'Garbodor', 631, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (632, 570, N'Zorua', 632, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (633, 571, N'Zoroark', 633, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (634, 572, N'Minccino', 634, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (635, 573, N'Cinccino', 635, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (636, 574, N'Gothita', 636, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (637, 575, N'Gothorita', 637, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (638, 576, N'Gothitelle', 638, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (639, 577, N'Solosis', 639, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (640, 578, N'Duosion', 640, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (641, 579, N'Reuniclus', 641, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (642, 580, N'Ducklett', 642, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (643, 581, N'Swanna', 643, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (644, 582, N'Vanillite', 644, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (645, 583, N'Vanillish', 645, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (646, 584, N'Vanilluxe', 646, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (647, 585, N'Deerling', 647, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (648, 586, N'Sawsbuck', 648, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (649, 587, N'Emolga', 649, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (650, 588, N'Karrablast', 650, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (651, 589, N'Escavalier', 651, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (652, 590, N'Foongus', 652, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (653, 591, N'Amoonguss', 653, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (654, 592, N'Frillish', 654, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (655, 593, N'Jellicent', 655, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (656, 594, N'Alomomola', 656, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (657, 595, N'Joltik', 657, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (658, 596, N'Galvantula', 658, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (659, 597, N'Ferroseed', 659, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (660, 598, N'Ferrothorn', 660, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (661, 599, N'Klink', 661, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (662, 600, N'Klang', 662, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (663, 601, N'Klinklang', 663, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (664, 602, N'Tynamo', 664, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (665, 603, N'Eelektrik', 665, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (666, 604, N'Eelektross', 666, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (667, 605, N'Elgyem', 667, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (668, 606, N'Beheeyem', 668, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (669, 607, N'Litwick', 669, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (670, 608, N'Lampent', 670, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (671, 609, N'Chandelure', 671, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (672, 610, N'Axew', 672, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (673, 611, N'Fraxure', 673, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (674, 612, N'Haxorus', 674, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (675, 613, N'Cubchoo', 675, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (676, 614, N'Beartic', 676, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (677, 615, N'Cryogonal', 677, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (678, 616, N'Shelmet', 678, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (679, 617, N'Accelgor', 679, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (680, 618, N'Stunfisk', 680, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (681, 619, N'Mienfoo', 681, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (682, 620, N'Mienshao', 682, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (683, 621, N'Druddigon', 683, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (684, 622, N'Golett', 684, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (685, 623, N'Golurk', 685, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (686, 624, N'Pawniard', 686, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (687, 625, N'Bisharp', 687, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (688, 626, N'Bouffalant', 688, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (689, 627, N'Rufflet', 689, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (690, 628, N'Braviary', 690, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (691, 629, N'Vullaby', 691, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (692, 630, N'Mandibuzz', 692, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (693, 631, N'Heatmor', 693, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (694, 632, N'Durant', 694, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (695, 633, N'Deino', 695, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (696, 634, N'Zweilous', 696, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (697, 635, N'Hydreigon', 697, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (698, 636, N'Larvesta', 698, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (699, 637, N'Volcarona', 699, 5)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (700, 638, N'Cobalion', 700, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (701, 639, N'Terrakion', 701, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (702, 640, N'Virizion', 702, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (703, 641, N'Tornadus Incarnate Forme', 703, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (704, 641, N'Tornadus Therian Forme', 704, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (705, 642, N'Thundurus Incarnate Forme', 705, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (706, 642, N'Thundurus Therian Forme', 706, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (707, 643, N'Reshiram', 707, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (708, 644, N'Zekrom', 708, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (709, 645, N'Landorus Incarnate Forme', 709, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (710, 645, N'Landorus Therian Forme', 710, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (711, 646, N'Kyurem', 711, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (712, 646, N'Kyurem Black Kyurem', 712, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (713, 646, N'Kyurem White Kyurem', 713, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (714, 647, N'Keldeo Ordinary Forme', 714, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (715, 647, N'Keldeo Resolute Forme', 715, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (716, 648, N'Meloetta Aria Forme', 716, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (717, 648, N'Meloetta Pirouette Forme', 717, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (718, 649, N'Genesect', 718, 5)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (719, 650, N'Chespin', 719, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (720, 651, N'Quilladin', 720, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (721, 652, N'Chesnaught', 721, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (722, 653, N'Fennekin', 722, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (723, 654, N'Braixen', 723, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (724, 655, N'Delphox', 724, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (725, 656, N'Froakie', 725, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (726, 657, N'Frogadier', 726, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (727, 658, N'Greninja', 727, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (728, 659, N'Bunnelby', 728, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (729, 660, N'Diggersby', 729, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (730, 661, N'Fletchling', 730, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (731, 662, N'Fletchinder', 731, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (732, 663, N'Talonflame', 732, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (733, 664, N'Scatterbug', 733, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (734, 665, N'Spewpa', 734, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (735, 666, N'Vivillon', 735, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (736, 667, N'Litleo', 736, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (737, 668, N'Pyroar', 737, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (738, 669, N'Flabébé', 738, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (739, 670, N'Floette', 739, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (740, 671, N'Florges', 740, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (741, 672, N'Skiddo', 741, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (742, 673, N'Gogoat', 742, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (743, 674, N'Pancham', 743, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (744, 675, N'Pangoro', 744, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (745, 676, N'Furfrou', 745, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (746, 677, N'Espurr', 746, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (747, 678, N'MeowsticMale', 747, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (748, 678, N'MeowsticFemale', 748, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (749, 679, N'Honedge', 749, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (750, 680, N'Doublade', 750, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (751, 681, N'AegislashBlade Forme', 751, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (752, 681, N'AegislashShield Forme', 752, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (753, 682, N'Spritzee', 753, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (754, 683, N'Aromatisse', 754, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (755, 684, N'Swirlix', 755, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (756, 685, N'Slurpuff', 756, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (757, 686, N'Inkay', 757, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (758, 687, N'Malamar', 758, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (759, 688, N'Binacle', 759, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (760, 689, N'Barbaracle', 760, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (761, 690, N'Skrelp', 761, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (762, 691, N'Dragalge', 762, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (763, 692, N'Clauncher', 763, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (764, 693, N'Clawitzer', 764, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (765, 694, N'Helioptile', 765, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (766, 695, N'Heliolisk', 766, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (767, 696, N'Tyrunt', 767, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (768, 697, N'Tyrantrum', 768, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (769, 698, N'Amaura', 769, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (770, 699, N'Aurorus', 770, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (771, 700, N'Sylveon', 771, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (772, 701, N'Hawlucha', 772, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (773, 702, N'Dedenne', 773, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (774, 703, N'Carbink', 774, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (775, 704, N'Goomy', 775, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (776, 705, N'Sliggoo', 776, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (777, 706, N'Goodra', 777, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (778, 707, N'Klefki', 778, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (779, 708, N'Phantump', 779, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (780, 709, N'Trevenant', 780, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (781, 710, N'Pumpkaboo Average Size', 781, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (782, 710, N'Pumpkaboo Small Size', 782, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (783, 710, N'Pumpkaboo Large Size', 783, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (784, 710, N'Pumpkaboo Super Size', 784, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (785, 711, N'Gourgeist Average Size', 785, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (786, 711, N'Gourgeist Small Size', 786, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (787, 711, N'Gourgeist Large Size', 787, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (788, 711, N'Gourgeist Super Size', 788, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (789, 712, N'Bergmite', 789, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (790, 713, N'Avalugg', 790, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (791, 714, N'Noibat', 791, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (792, 715, N'Noivern', 792, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (793, 716, N'Xerneas', 793, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (794, 717, N'Yveltal', 794, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (795, 718, N'Zygarde', 795, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (796, 719, N'Diancie', 796, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (797, 719, N'Mega Diancie', 797, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (798, 720, N'Hoopa Confined', 798, 6)
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (799, 720, N'Hoopa Unbound', 799, 6)
GO
INSERT [dbo].[Pokemon] ([ID], [Pokedex_Number], [Name], [Stats_ID], [Generation_ID]) VALUES (800, 721, N'Volcanion', 800, 6)
SET IDENTITY_INSERT [dbo].[Pokemon] OFF
GO
SET IDENTITY_INSERT [dbo].[PokemonStatistic] ON 

INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (1, 1, 2, 45, 49, 49, 65, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (2, 1, 2, 60, 62, 63, 80, 80, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (3, 1, 2, 80, 82, 83, 100, 100, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (4, 1, 2, 80, 100, 123, 122, 120, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (5, 3, NULL, 39, 52, 43, 60, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (6, 3, NULL, 58, 64, 58, 80, 65, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (7, 3, 4, 78, 84, 78, 109, 85, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (8, 3, 5, 78, 130, 111, 130, 85, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (9, 3, 4, 78, 104, 78, 159, 115, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (10, 6, NULL, 44, 48, 65, 50, 64, 43)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (11, 6, NULL, 59, 63, 80, 65, 80, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (12, 6, NULL, 79, 83, 100, 85, 105, 78)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (13, 6, NULL, 79, 103, 120, 135, 115, 78)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (14, 7, NULL, 45, 30, 35, 20, 20, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (15, 7, NULL, 50, 20, 55, 25, 25, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (16, 7, 4, 60, 45, 50, 90, 80, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (17, 7, 2, 40, 35, 30, 20, 20, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (18, 7, 2, 45, 25, 50, 25, 25, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (19, 7, 2, 65, 90, 40, 45, 80, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (20, 7, 2, 65, 150, 40, 15, 80, 145)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (21, 8, 4, 40, 45, 40, 35, 35, 56)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (22, 8, 4, 63, 60, 55, 50, 50, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (23, 8, 4, 83, 80, 75, 70, 70, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (24, 8, 4, 83, 80, 80, 135, 80, 121)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (25, 8, NULL, 30, 56, 35, 25, 35, 72)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (26, 8, NULL, 55, 81, 60, 50, 70, 97)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (27, 8, 4, 40, 60, 30, 31, 31, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (28, 8, 4, 65, 90, 65, 61, 61, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (29, 2, NULL, 35, 60, 44, 40, 54, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (30, 2, NULL, 60, 85, 69, 65, 79, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (31, 9, NULL, 35, 55, 40, 50, 50, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (32, 9, NULL, 60, 90, 55, 90, 80, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (33, 10, NULL, 50, 75, 85, 20, 30, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (34, 10, NULL, 75, 100, 110, 45, 55, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (35, 2, NULL, 55, 47, 52, 40, 40, 41)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (36, 2, NULL, 70, 62, 67, 55, 55, 56)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (37, 2, 10, 90, 92, 87, 75, 85, 76)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (38, 2, NULL, 46, 57, 40, 40, 40, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (39, 2, NULL, 61, 72, 57, 55, 55, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (40, 2, 10, 81, 102, 77, 85, 75, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (41, 11, NULL, 70, 45, 48, 60, 65, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (42, 11, NULL, 95, 70, 73, 95, 90, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (43, 3, NULL, 38, 41, 40, 50, 65, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (44, 3, NULL, 73, 76, 75, 81, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (45, 8, 11, 115, 45, 20, 45, 25, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (46, 8, 11, 140, 70, 45, 85, 50, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (47, 2, 4, 40, 45, 35, 30, 40, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (48, 2, 4, 75, 80, 70, 65, 75, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (49, 1, 2, 45, 50, 55, 75, 65, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (50, 1, 2, 60, 65, 70, 85, 75, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (51, 1, 2, 75, 80, 85, 110, 90, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (52, 7, 1, 35, 70, 55, 45, 55, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (53, 7, 1, 60, 95, 80, 60, 80, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (54, 7, 2, 60, 55, 50, 40, 55, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (55, 7, 2, 70, 65, 60, 90, 75, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (56, 10, NULL, 10, 55, 25, 35, 45, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (57, 10, NULL, 35, 80, 50, 50, 70, 120)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (58, 8, NULL, 40, 45, 35, 40, 40, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (59, 8, NULL, 65, 70, 60, 65, 65, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (60, 6, NULL, 50, 52, 48, 65, 50, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (61, 6, NULL, 80, 82, 78, 95, 80, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (62, 12, NULL, 40, 80, 35, 35, 45, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (63, 12, NULL, 65, 105, 60, 60, 70, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (64, 3, NULL, 55, 70, 45, 70, 50, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (65, 3, NULL, 90, 110, 80, 100, 80, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (66, 6, NULL, 40, 50, 40, 40, 40, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (67, 6, NULL, 65, 65, 65, 50, 50, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (68, 6, 12, 90, 95, 95, 70, 90, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (69, 13, NULL, 25, 20, 15, 105, 55, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (70, 13, NULL, 40, 35, 30, 120, 70, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (71, 13, NULL, 55, 50, 45, 135, 95, 120)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (72, 13, NULL, 55, 50, 65, 175, 95, 150)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (73, 12, NULL, 70, 80, 50, 35, 35, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (74, 12, NULL, 80, 100, 70, 50, 60, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (75, 12, NULL, 90, 130, 80, 65, 85, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (76, 1, 2, 50, 75, 35, 70, 30, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (77, 1, 2, 65, 90, 50, 85, 45, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (78, 1, 2, 80, 105, 65, 100, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (79, 6, 2, 40, 40, 35, 50, 100, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (80, 6, 2, 80, 70, 65, 80, 120, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (81, 14, 10, 40, 80, 100, 30, 30, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (82, 14, 10, 55, 95, 115, 45, 45, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (83, 14, 10, 80, 120, 130, 55, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (84, 3, NULL, 50, 85, 55, 65, 65, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (85, 3, NULL, 65, 100, 70, 80, 80, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (86, 6, 13, 90, 65, 65, 40, 40, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (87, 6, 13, 95, 75, 110, 100, 80, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (88, 6, 13, 95, 75, 180, 130, 80, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (89, 9, 15, 25, 35, 70, 95, 55, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (90, 9, 15, 50, 60, 95, 120, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (91, 8, 4, 52, 65, 55, 58, 62, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (92, 8, 4, 35, 85, 45, 35, 35, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (93, 8, 4, 60, 110, 70, 60, 60, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (94, 6, NULL, 65, 45, 55, 45, 70, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (95, 6, 16, 90, 70, 80, 70, 95, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (96, 2, NULL, 80, 80, 50, 40, 50, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (97, 2, NULL, 105, 105, 75, 65, 100, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (98, 6, NULL, 30, 65, 100, 45, 25, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (99, 6, 16, 50, 95, 180, 85, 45, 70)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (100, 17, 2, 30, 35, 30, 100, 35, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (101, 17, 2, 45, 50, 45, 115, 55, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (102, 17, 2, 60, 65, 60, 130, 75, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (103, 17, 2, 60, 65, 80, 170, 95, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (104, 14, 10, 35, 45, 160, 30, 45, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (105, 13, NULL, 60, 48, 45, 43, 90, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (106, 13, NULL, 85, 73, 70, 73, 115, 67)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (107, 6, NULL, 30, 105, 90, 25, 25, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (108, 6, NULL, 55, 130, 115, 50, 50, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (109, 9, NULL, 40, 30, 50, 55, 55, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (110, 9, NULL, 60, 50, 70, 80, 80, 140)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (111, 1, 13, 60, 40, 80, 60, 45, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (112, 1, 13, 95, 95, 85, 125, 65, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (113, 10, NULL, 50, 50, 95, 40, 50, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (114, 10, NULL, 60, 80, 110, 50, 80, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (115, 12, NULL, 50, 120, 53, 35, 110, 87)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (116, 12, NULL, 50, 105, 79, 35, 110, 76)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (117, 8, NULL, 90, 55, 75, 60, 75, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (118, 2, NULL, 40, 65, 95, 60, 45, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (119, 2, NULL, 65, 90, 120, 85, 70, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (120, 10, 14, 80, 85, 95, 30, 30, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (121, 10, 14, 105, 130, 120, 45, 45, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (122, 8, NULL, 250, 5, 5, 35, 105, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (123, 1, NULL, 65, 55, 115, 100, 40, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (124, 8, NULL, 105, 95, 80, 40, 80, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (125, 8, NULL, 105, 125, 100, 60, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (126, 6, NULL, 30, 40, 70, 70, 25, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (127, 6, NULL, 55, 65, 95, 95, 45, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (128, 6, NULL, 45, 67, 60, 35, 50, 63)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (129, 6, NULL, 80, 92, 65, 65, 80, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (130, 6, NULL, 30, 45, 55, 70, 55, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (131, 6, 13, 60, 75, 85, 100, 85, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (132, 13, 11, 40, 45, 65, 100, 120, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (133, 7, 4, 70, 110, 80, 55, 80, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (134, 16, 13, 65, 50, 35, 115, 95, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (135, 9, NULL, 65, 83, 57, 95, 85, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (136, 3, NULL, 65, 95, 57, 100, 85, 93)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (137, 7, NULL, 65, 125, 100, 55, 70, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (138, 7, 4, 65, 155, 120, 65, 90, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (139, 8, NULL, 75, 100, 95, 40, 70, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (140, 6, NULL, 20, 10, 55, 15, 20, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (141, 6, 4, 95, 125, 79, 60, 100, 81)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (142, 6, 18, 95, 155, 109, 70, 130, 81)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (143, 6, 16, 130, 85, 80, 85, 95, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (144, 8, NULL, 48, 48, 48, 48, 48, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (145, 8, NULL, 55, 55, 50, 45, 65, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (146, 6, NULL, 130, 65, 60, 110, 95, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (147, 9, NULL, 65, 65, 60, 110, 95, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (148, 3, NULL, 65, 130, 60, 95, 110, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (149, 8, NULL, 65, 60, 70, 85, 75, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (150, 14, 6, 35, 40, 100, 90, 55, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (151, 14, 6, 70, 60, 125, 115, 70, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (152, 14, 6, 30, 80, 90, 55, 45, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (153, 14, 6, 60, 115, 105, 65, 70, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (154, 14, 4, 80, 105, 65, 60, 75, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (155, 14, 4, 80, 135, 85, 70, 95, 150)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (156, 8, NULL, 160, 110, 65, 65, 110, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (157, 16, 4, 90, 85, 100, 95, 125, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (158, 9, 4, 90, 90, 85, 125, 90, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (159, 3, 4, 90, 100, 90, 125, 85, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (160, 5, NULL, 41, 64, 45, 50, 50, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (161, 5, NULL, 61, 84, 65, 70, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (162, 5, 4, 91, 134, 95, 100, 100, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (163, 13, NULL, 106, 110, 90, 154, 90, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (164, 13, 12, 106, 190, 100, 154, 100, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (165, 13, NULL, 106, 150, 70, 194, 120, 140)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (166, 13, NULL, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (167, 1, NULL, 45, 49, 65, 49, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (168, 1, NULL, 60, 62, 80, 63, 80, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (169, 1, NULL, 80, 82, 100, 83, 100, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (170, 3, NULL, 39, 52, 43, 60, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (171, 3, NULL, 58, 64, 58, 80, 65, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (172, 3, NULL, 78, 84, 78, 109, 85, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (173, 6, NULL, 50, 65, 64, 44, 48, 43)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (174, 6, NULL, 65, 80, 80, 59, 63, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (175, 6, NULL, 85, 105, 100, 79, 83, 78)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (176, 8, NULL, 35, 46, 34, 35, 45, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (177, 8, NULL, 85, 76, 64, 45, 55, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (178, 8, 4, 60, 30, 30, 36, 56, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (179, 8, 4, 100, 50, 50, 76, 96, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (180, 7, 4, 40, 20, 30, 40, 80, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (181, 7, 4, 55, 35, 50, 55, 110, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (182, 7, 2, 40, 60, 40, 40, 40, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (183, 7, 2, 70, 90, 70, 60, 60, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (184, 2, 4, 85, 90, 80, 70, 80, 130)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (185, 6, 9, 75, 38, 38, 56, 56, 67)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (186, 6, 9, 125, 58, 58, 76, 76, 67)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (187, 9, NULL, 20, 40, 15, 35, 35, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (188, 11, NULL, 50, 25, 28, 45, 55, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (189, 8, 11, 90, 30, 15, 40, 20, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (190, 11, NULL, 35, 20, 65, 40, 65, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (191, 11, 4, 55, 40, 85, 80, 105, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (192, 13, 4, 40, 50, 45, 70, 45, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (193, 13, 4, 65, 75, 70, 95, 70, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (194, 9, NULL, 55, 40, 40, 65, 45, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (195, 9, NULL, 70, 55, 55, 80, 60, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (196, 9, NULL, 90, 75, 85, 115, 90, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (197, 9, 5, 90, 95, 105, 165, 110, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (198, 1, NULL, 75, 80, 95, 90, 100, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (199, 6, 11, 70, 20, 50, 20, 50, 40)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (200, 6, 11, 100, 50, 80, 60, 80, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (201, 14, NULL, 70, 100, 115, 30, 65, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (202, 6, NULL, 90, 75, 75, 90, 100, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (203, 1, 4, 35, 35, 40, 35, 55, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (204, 1, 4, 55, 45, 50, 45, 65, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (205, 1, 4, 75, 55, 70, 55, 95, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (206, 8, NULL, 55, 70, 55, 40, 55, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (207, 1, NULL, 30, 30, 30, 30, 30, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (208, 1, NULL, 75, 75, 55, 105, 85, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (209, 7, 4, 65, 65, 45, 75, 45, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (210, 6, 10, 55, 45, 45, 25, 25, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (211, 6, 10, 95, 85, 85, 65, 65, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (212, 13, NULL, 65, 65, 60, 130, 95, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (213, 18, NULL, 95, 65, 110, 60, 130, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (214, 18, 4, 60, 85, 42, 85, 42, 91)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (215, 6, 13, 95, 75, 80, 100, 110, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (216, 17, NULL, 60, 60, 60, 85, 85, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (217, 13, NULL, 48, 72, 48, 72, 48, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (218, 13, NULL, 190, 33, 58, 33, 58, 33)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (219, 8, 13, 70, 80, 65, 90, 65, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (220, 7, NULL, 50, 65, 90, 35, 35, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (221, 7, 15, 75, 90, 140, 60, 60, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (222, 8, NULL, 100, 70, 70, 65, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (223, 10, 4, 65, 75, 105, 35, 65, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (224, 15, 10, 75, 85, 200, 55, 65, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (225, 15, 10, 75, 125, 230, 55, 95, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (226, 11, NULL, 60, 80, 50, 40, 40, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (227, 11, NULL, 90, 120, 75, 60, 60, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (228, 6, 2, 65, 95, 75, 55, 55, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (229, 7, 15, 70, 130, 100, 55, 80, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (230, 7, 15, 70, 150, 140, 65, 100, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (231, 7, 14, 20, 10, 230, 10, 230, 5)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (232, 7, 12, 80, 125, 75, 40, 95, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (233, 7, 12, 80, 185, 115, 40, 105, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (234, 18, 16, 55, 95, 55, 35, 75, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (235, 8, NULL, 60, 80, 50, 50, 50, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (236, 8, NULL, 90, 130, 75, 75, 75, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (237, 3, NULL, 40, 40, 40, 70, 40, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (238, 3, 14, 50, 50, 120, 80, 80, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (239, 16, 10, 50, 50, 40, 30, 30, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (240, 16, 10, 100, 100, 80, 60, 60, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (241, 6, 14, 55, 55, 85, 65, 85, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (242, 6, NULL, 35, 65, 35, 65, 35, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (243, 6, NULL, 75, 105, 75, 105, 75, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (244, 16, 4, 45, 55, 45, 65, 45, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (245, 6, 4, 65, 40, 70, 80, 140, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (246, 15, 4, 65, 80, 140, 40, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (247, 18, 3, 45, 60, 30, 80, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (248, 18, 3, 75, 90, 50, 110, 80, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (249, 18, 3, 75, 90, 90, 140, 90, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (250, 6, 5, 75, 95, 95, 95, 95, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (251, 10, NULL, 90, 60, 60, 40, 40, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (252, 10, NULL, 90, 120, 120, 60, 60, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (253, 8, NULL, 85, 80, 90, 105, 95, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (254, 8, NULL, 73, 95, 62, 85, 65, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (255, 8, NULL, 55, 20, 35, 20, 45, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (256, 12, NULL, 35, 35, 35, 35, 35, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (257, 12, NULL, 50, 95, 95, 35, 110, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (258, 16, 13, 45, 30, 15, 85, 65, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (259, 9, NULL, 45, 63, 37, 65, 55, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (260, 3, NULL, 45, 75, 37, 70, 55, 83)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (261, 8, NULL, 95, 80, 105, 40, 70, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (262, 8, NULL, 255, 10, 10, 75, 135, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (263, 9, NULL, 90, 85, 75, 115, 100, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (264, 3, NULL, 115, 115, 85, 90, 75, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (265, 6, NULL, 100, 75, 115, 90, 115, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (266, 14, 10, 50, 64, 50, 45, 50, 41)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (267, 14, 10, 70, 84, 70, 65, 70, 51)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (268, 14, 18, 100, 134, 110, 95, 100, 61)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (269, 14, 18, 100, 164, 150, 95, 120, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (270, 13, 4, 106, 90, 130, 90, 154, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (271, 3, 4, 106, 130, 90, 110, 154, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (272, 13, 1, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (273, 1, NULL, 40, 45, 35, 65, 55, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (274, 1, NULL, 50, 65, 45, 85, 65, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (275, 1, NULL, 70, 85, 65, 105, 85, 120)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (276, 1, 5, 70, 110, 75, 145, 85, 145)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (277, 3, NULL, 45, 60, 40, 70, 50, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (278, 3, 12, 60, 85, 60, 85, 60, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (279, 3, 12, 80, 120, 70, 110, 70, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (280, 3, 12, 80, 160, 80, 130, 80, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (281, 6, NULL, 50, 70, 50, 50, 50, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (282, 6, 10, 70, 85, 70, 60, 70, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (283, 6, 10, 100, 110, 90, 85, 90, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (284, 6, 10, 100, 150, 110, 95, 110, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (285, 18, NULL, 35, 55, 35, 30, 30, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (286, 18, NULL, 70, 90, 70, 60, 60, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (287, 8, NULL, 38, 30, 41, 30, 41, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (288, 8, NULL, 78, 70, 61, 50, 61, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (289, 7, NULL, 45, 45, 35, 20, 30, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (290, 7, NULL, 50, 35, 55, 25, 25, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (291, 7, 4, 60, 70, 50, 100, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (292, 7, NULL, 50, 35, 55, 25, 25, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (293, 7, 2, 60, 50, 70, 50, 90, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (294, 6, 1, 40, 30, 30, 40, 50, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (295, 6, 1, 60, 50, 50, 60, 70, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (296, 6, 1, 80, 70, 70, 90, 100, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (297, 1, NULL, 40, 40, 50, 30, 30, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (298, 1, 18, 70, 70, 40, 60, 40, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (299, 1, 18, 90, 100, 60, 90, 60, 80)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (300, 8, 4, 40, 55, 30, 30, 30, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (301, 8, 4, 60, 85, 60, 50, 50, 125)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (302, 6, 4, 40, 30, 30, 55, 30, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (303, 6, 4, 60, 50, 100, 85, 70, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (304, 13, 11, 28, 25, 25, 45, 35, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (305, 13, 11, 38, 35, 35, 65, 55, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (306, 13, 11, 68, 65, 65, 125, 115, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (307, 13, 11, 68, 85, 65, 165, 135, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (308, 7, 6, 40, 30, 32, 50, 52, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (309, 7, 4, 70, 60, 62, 80, 82, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (310, 1, NULL, 60, 40, 60, 40, 60, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (311, 1, 12, 60, 130, 80, 60, 60, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (312, 8, NULL, 60, 60, 60, 35, 35, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (313, 8, NULL, 80, 80, 80, 55, 55, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (314, 8, NULL, 150, 160, 100, 95, 65, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (315, 7, 10, 31, 45, 90, 30, 30, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (316, 7, 4, 61, 90, 45, 50, 50, 160)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (317, 7, 17, 1, 90, 45, 30, 30, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (318, 8, NULL, 64, 51, 23, 51, 23, 28)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (319, 8, NULL, 84, 71, 43, 71, 43, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (320, 8, NULL, 104, 91, 63, 91, 73, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (321, 12, NULL, 72, 60, 30, 20, 30, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (322, 12, NULL, 144, 120, 60, 40, 60, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (323, 8, 11, 50, 20, 40, 20, 40, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (324, 14, NULL, 30, 45, 135, 45, 90, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (325, 8, NULL, 50, 45, 45, 35, 35, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (326, 8, NULL, 70, 65, 65, 55, 55, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (327, 18, 17, 50, 75, 75, 65, 65, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (328, 18, 17, 50, 85, 125, 85, 115, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (329, 15, 11, 50, 85, 85, 55, 55, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (330, 15, 11, 50, 105, 125, 55, 95, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (331, 15, 14, 50, 70, 100, 40, 40, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (332, 15, 14, 60, 90, 140, 50, 50, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (333, 15, 14, 70, 110, 180, 60, 60, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (334, 15, NULL, 70, 140, 230, 60, 80, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (335, 12, 13, 30, 40, 55, 40, 55, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (336, 12, 13, 60, 60, 75, 60, 75, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (337, 12, 13, 60, 100, 85, 80, 85, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (338, 9, NULL, 40, 45, 40, 65, 40, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (339, 9, NULL, 70, 75, 60, 105, 60, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (340, 9, NULL, 70, 75, 80, 135, 80, 135)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (341, 9, NULL, 60, 50, 40, 85, 75, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (342, 9, NULL, 60, 40, 50, 75, 85, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (343, 7, NULL, 65, 73, 55, 47, 75, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (344, 7, NULL, 65, 47, 55, 73, 75, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (345, 1, 2, 50, 60, 45, 100, 80, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (346, 2, NULL, 70, 43, 53, 43, 53, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (347, 2, NULL, 100, 73, 83, 73, 83, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (348, 6, 18, 45, 90, 20, 65, 20, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (349, 6, 18, 70, 120, 40, 95, 40, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (350, 6, 18, 70, 140, 70, 110, 65, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (351, 6, NULL, 130, 70, 35, 70, 35, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (352, 6, NULL, 170, 90, 45, 90, 45, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (353, 3, 10, 60, 60, 40, 65, 45, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (354, 3, 10, 70, 100, 70, 105, 75, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (355, 3, 10, 70, 120, 100, 145, 105, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (356, 3, NULL, 70, 85, 140, 85, 70, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (357, 13, NULL, 60, 25, 35, 70, 80, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (358, 13, NULL, 80, 45, 65, 90, 110, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (359, 8, NULL, 60, 60, 60, 60, 60, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (360, 10, NULL, 45, 100, 45, 45, 45, 10)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (361, 10, 5, 50, 70, 50, 50, 50, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (362, 10, 5, 80, 100, 80, 80, 80, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (363, 1, NULL, 50, 85, 40, 85, 40, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (364, 1, 18, 70, 115, 60, 115, 60, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (365, 8, 4, 45, 40, 60, 40, 75, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (366, 5, 4, 75, 70, 90, 70, 105, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (367, 5, 11, 75, 110, 110, 110, 105, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (368, 8, NULL, 73, 115, 60, 60, 60, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (369, 2, NULL, 73, 100, 60, 100, 60, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (370, 14, 13, 70, 55, 65, 95, 85, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (371, 14, 13, 70, 95, 85, 55, 65, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (372, 6, 10, 50, 48, 43, 46, 41, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (373, 6, 10, 110, 78, 73, 76, 71, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (374, 6, NULL, 43, 80, 65, 50, 35, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (375, 6, 18, 63, 120, 85, 90, 55, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (376, 10, 13, 40, 40, 55, 40, 70, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (377, 10, 13, 60, 70, 105, 70, 120, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (378, 14, 1, 66, 41, 77, 61, 87, 23)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (379, 14, 1, 86, 81, 97, 81, 107, 43)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (380, 14, 7, 45, 95, 50, 40, 50, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (381, 14, 7, 75, 125, 100, 70, 80, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (382, 6, NULL, 20, 15, 20, 10, 55, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (383, 6, NULL, 95, 60, 79, 100, 125, 81)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (384, 8, NULL, 70, 70, 70, 70, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (385, 8, NULL, 60, 90, 70, 60, 120, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (386, 17, NULL, 44, 75, 35, 63, 33, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (387, 17, NULL, 64, 115, 65, 83, 63, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (388, 17, NULL, 64, 165, 75, 93, 83, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (389, 17, NULL, 20, 40, 90, 30, 90, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (390, 17, NULL, 40, 70, 130, 60, 130, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (391, 1, 4, 99, 68, 83, 72, 87, 51)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (392, 13, NULL, 65, 50, 70, 95, 80, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (393, 18, NULL, 65, 130, 60, 75, 60, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (394, 18, NULL, 65, 150, 60, 115, 60, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (395, 13, NULL, 95, 23, 48, 23, 48, 23)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (396, 16, NULL, 50, 50, 50, 50, 50, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (397, 16, NULL, 80, 80, 80, 80, 80, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (398, 16, NULL, 80, 120, 80, 120, 80, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (399, 16, 6, 70, 40, 50, 55, 50, 25)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (400, 16, 6, 90, 60, 70, 75, 70, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (401, 16, 6, 110, 80, 90, 95, 90, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (402, 6, NULL, 35, 64, 85, 74, 55, 32)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (403, 6, NULL, 55, 104, 105, 94, 75, 52)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (404, 6, NULL, 55, 84, 105, 114, 75, 52)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (405, 6, 14, 100, 90, 130, 45, 65, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (406, 6, NULL, 43, 30, 55, 40, 65, 97)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (407, 5, NULL, 45, 75, 60, 40, 30, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (408, 5, NULL, 65, 95, 100, 60, 50, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (409, 5, 4, 95, 135, 80, 110, 80, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (410, 5, 4, 95, 145, 130, 120, 90, 120)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (411, 15, 13, 40, 55, 80, 35, 60, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (412, 15, 13, 60, 75, 100, 55, 80, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (413, 15, 13, 80, 135, 130, 95, 90, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (414, 15, 13, 80, 145, 150, 105, 110, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (415, 14, NULL, 80, 100, 200, 50, 100, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (416, 16, NULL, 80, 50, 100, 100, 200, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (417, 15, NULL, 80, 75, 150, 75, 150, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (418, 5, 13, 80, 80, 90, 110, 130, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (419, 5, 13, 80, 100, 120, 140, 150, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (420, 5, 13, 80, 90, 80, 130, 110, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (421, 5, 13, 80, 130, 100, 160, 120, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (422, 6, NULL, 100, 100, 90, 150, 140, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (423, 6, NULL, 100, 150, 90, 180, 160, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (424, 10, NULL, 100, 150, 140, 100, 90, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (425, 10, 3, 100, 180, 160, 150, 90, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (426, 5, 4, 105, 150, 90, 150, 90, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (427, 5, 4, 105, 180, 100, 180, 100, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (428, 15, 13, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (429, 13, NULL, 50, 150, 50, 150, 50, 150)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (430, 13, NULL, 50, 180, 20, 180, 20, 150)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (431, 13, NULL, 50, 70, 160, 70, 160, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (432, 13, NULL, 50, 95, 90, 95, 90, 180)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (433, 1, NULL, 55, 68, 64, 45, 55, 31)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (434, 1, NULL, 75, 89, 85, 55, 65, 36)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (435, 1, 10, 95, 109, 105, 75, 85, 56)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (436, 3, NULL, 44, 58, 44, 58, 44, 61)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (437, 3, 12, 64, 78, 52, 78, 52, 81)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (438, 3, 12, 76, 104, 71, 104, 71, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (439, 6, NULL, 53, 51, 53, 61, 56, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (440, 6, NULL, 64, 66, 68, 81, 76, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (441, 6, 15, 84, 86, 88, 111, 101, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (442, 8, 4, 40, 55, 30, 30, 30, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (443, 8, 4, 55, 75, 50, 40, 40, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (444, 8, 4, 85, 120, 70, 50, 60, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (445, 8, NULL, 59, 45, 40, 35, 40, 31)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (446, 8, 6, 79, 85, 60, 55, 60, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (447, 7, NULL, 37, 25, 41, 25, 41, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (448, 7, NULL, 77, 85, 51, 55, 51, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (449, 9, NULL, 45, 65, 34, 40, 34, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (450, 9, NULL, 60, 85, 49, 60, 49, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (451, 9, NULL, 80, 120, 79, 95, 79, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (452, 1, 2, 40, 30, 35, 50, 70, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (453, 1, 2, 60, 70, 65, 125, 105, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (454, 14, NULL, 67, 125, 40, 30, 30, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (455, 14, NULL, 97, 165, 60, 65, 50, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (456, 14, 15, 30, 42, 118, 42, 88, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (457, 14, 15, 60, 52, 168, 47, 138, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (458, 7, NULL, 40, 29, 45, 29, 45, 36)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (459, 7, 1, 60, 59, 85, 79, 105, 36)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (460, 7, 10, 60, 79, 105, 59, 85, 36)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (461, 7, 15, 60, 69, 95, 69, 95, 36)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (462, 7, 4, 70, 94, 50, 94, 50, 66)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (463, 7, 4, 30, 30, 42, 30, 42, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (464, 7, 4, 70, 80, 102, 80, 102, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (465, 9, NULL, 60, 45, 70, 45, 90, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (466, 6, NULL, 55, 65, 35, 60, 30, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (467, 6, NULL, 85, 105, 55, 85, 50, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (468, 1, NULL, 45, 35, 45, 62, 53, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (469, 1, NULL, 70, 60, 70, 87, 78, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (470, 6, NULL, 76, 48, 48, 57, 62, 34)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (471, 6, 10, 111, 83, 68, 92, 82, 39)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (472, 8, NULL, 75, 100, 66, 60, 66, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (473, 17, 4, 90, 50, 34, 60, 44, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (474, 17, 4, 150, 80, 44, 90, 54, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (475, 8, NULL, 55, 66, 44, 44, 56, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (476, 8, NULL, 65, 76, 84, 54, 96, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (477, 8, 12, 65, 136, 94, 54, 96, 135)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (478, 17, NULL, 60, 60, 60, 105, 105, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (479, 18, 4, 100, 125, 52, 105, 52, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (480, 8, NULL, 49, 55, 42, 42, 37, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (481, 8, NULL, 71, 82, 64, 64, 59, 112)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (482, 13, NULL, 45, 30, 50, 65, 50, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (483, 2, 18, 63, 63, 47, 41, 41, 74)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (484, 2, 18, 103, 93, 67, 71, 61, 84)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (485, 15, 13, 57, 24, 86, 24, 86, 23)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (486, 15, 13, 67, 89, 116, 79, 116, 33)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (487, 14, NULL, 50, 80, 95, 10, 45, 10)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (488, 13, 11, 20, 25, 45, 70, 90, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (489, 8, NULL, 100, 5, 5, 15, 65, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (490, 8, 4, 76, 65, 45, 92, 42, 91)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (491, 17, 18, 50, 92, 108, 92, 108, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (492, 5, 10, 58, 70, 45, 40, 45, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (493, 5, 10, 68, 90, 65, 50, 55, 82)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (494, 5, 10, 108, 130, 95, 80, 85, 102)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (495, 5, 10, 108, 170, 115, 120, 95, 92)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (496, 8, NULL, 135, 85, 40, 40, 85, 5)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (497, 12, NULL, 40, 70, 40, 35, 40, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (498, 12, 15, 70, 110, 70, 115, 70, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (499, 12, 15, 70, 145, 88, 140, 70, 112)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (500, 10, NULL, 68, 72, 78, 38, 42, 32)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (501, 10, NULL, 108, 112, 118, 68, 72, 47)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (502, 2, 7, 40, 50, 90, 30, 55, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (503, 2, 18, 70, 90, 110, 60, 75, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (504, 2, 12, 48, 61, 40, 61, 40, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (505, 2, 12, 83, 106, 65, 86, 65, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (506, 1, NULL, 74, 100, 72, 90, 72, 46)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (507, 6, NULL, 49, 49, 56, 49, 61, 66)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (508, 6, NULL, 69, 69, 76, 69, 86, 91)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (509, 6, 4, 45, 20, 50, 60, 120, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (510, 1, 16, 60, 62, 50, 62, 60, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (511, 1, 16, 90, 92, 75, 92, 85, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (512, 1, 16, 90, 132, 105, 132, 105, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (513, 18, 16, 70, 120, 65, 45, 85, 125)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (514, 9, 15, 70, 70, 115, 130, 90, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (515, 8, NULL, 110, 85, 95, 80, 95, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (516, 10, 14, 115, 140, 130, 55, 55, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (517, 1, NULL, 100, 100, 125, 110, 50, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (518, 9, NULL, 75, 123, 67, 95, 85, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (519, 3, NULL, 75, 95, 67, 125, 95, 83)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (520, 11, 4, 85, 50, 95, 120, 115, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (521, 7, 4, 86, 76, 86, 116, 56, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (522, 1, NULL, 65, 110, 130, 60, 65, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (523, 16, NULL, 65, 60, 110, 130, 95, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (524, 10, 4, 75, 95, 125, 45, 75, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (525, 16, 10, 110, 130, 80, 70, 60, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (526, 8, NULL, 85, 80, 70, 135, 75, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (527, 13, 12, 68, 125, 65, 65, 115, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (528, 13, 12, 68, 165, 95, 65, 115, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (529, 14, 15, 60, 55, 145, 75, 150, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (530, 17, NULL, 45, 100, 135, 65, 135, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (531, 16, 17, 70, 80, 70, 80, 70, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (532, 9, 17, 50, 50, 77, 95, 77, 91)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (533, 9, 3, 50, 65, 107, 105, 107, 86)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (534, 9, 6, 50, 65, 107, 105, 107, 86)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (535, 9, 16, 50, 65, 107, 105, 107, 86)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (536, 9, 4, 50, 65, 107, 105, 107, 86)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (537, 9, 1, 50, 65, 107, 105, 107, 86)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (538, 13, NULL, 75, 75, 130, 75, 130, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (539, 13, NULL, 80, 105, 105, 105, 105, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (540, 13, NULL, 75, 125, 70, 125, 70, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (541, 15, 5, 100, 120, 120, 150, 100, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (542, 6, 5, 90, 120, 100, 150, 120, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (543, 3, 15, 91, 90, 106, 130, 106, 77)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (544, 8, NULL, 110, 160, 110, 80, 110, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (545, 17, 5, 150, 100, 120, 100, 120, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (546, 17, 5, 150, 120, 100, 120, 100, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (547, 13, NULL, 120, 70, 120, 75, 130, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (548, 6, NULL, 80, 80, 80, 80, 80, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (549, 6, NULL, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (550, 18, NULL, 70, 90, 90, 135, 90, 125)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (551, 1, NULL, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (552, 1, 4, 100, 103, 75, 120, 75, 127)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (553, 8, NULL, 120, 120, 120, 120, 120, 120)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (554, 13, 3, 100, 100, 100, 100, 100, 100)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (555, 1, NULL, 45, 45, 55, 45, 55, 63)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (556, 1, NULL, 60, 60, 75, 60, 75, 83)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (557, 1, NULL, 75, 75, 95, 75, 95, 113)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (558, 3, NULL, 65, 63, 45, 45, 45, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (559, 3, 12, 90, 93, 55, 70, 55, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (560, 3, 12, 110, 123, 65, 100, 65, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (561, 6, NULL, 55, 55, 45, 63, 45, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (562, 6, NULL, 75, 75, 60, 83, 60, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (563, 6, NULL, 95, 100, 85, 108, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (564, 8, NULL, 45, 55, 39, 35, 39, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (565, 8, NULL, 60, 85, 69, 60, 69, 77)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (566, 8, NULL, 45, 60, 45, 25, 45, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (567, 8, NULL, 65, 80, 65, 35, 65, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (568, 8, NULL, 85, 110, 90, 45, 90, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (569, 18, NULL, 41, 50, 37, 50, 37, 66)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (570, 18, NULL, 64, 88, 50, 88, 50, 106)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (571, 1, NULL, 50, 53, 48, 53, 48, 64)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (572, 1, NULL, 75, 98, 63, 98, 63, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (573, 3, NULL, 50, 53, 48, 53, 48, 64)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (574, 3, NULL, 75, 98, 63, 98, 63, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (575, 6, NULL, 50, 53, 48, 53, 48, 64)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (576, 6, NULL, 75, 98, 63, 98, 63, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (577, 13, NULL, 76, 25, 45, 67, 55, 24)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (578, 13, NULL, 116, 55, 85, 107, 95, 29)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (579, 8, 4, 50, 55, 50, 36, 30, 43)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (580, 8, 4, 62, 77, 62, 50, 42, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (581, 8, 4, 80, 115, 80, 65, 55, 93)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (582, 9, NULL, 45, 60, 32, 50, 32, 76)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (583, 9, NULL, 75, 100, 63, 80, 63, 116)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (584, 14, NULL, 55, 75, 85, 25, 25, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (585, 14, NULL, 70, 105, 105, 50, 40, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (586, 14, NULL, 85, 135, 130, 60, 80, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (587, 13, 4, 55, 45, 43, 55, 43, 72)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (588, 13, 4, 67, 57, 55, 77, 55, 114)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (589, 10, NULL, 60, 85, 40, 30, 45, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (590, 10, 15, 110, 135, 60, 50, 65, 88)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (591, 8, NULL, 103, 60, 86, 60, 86, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (592, 8, 11, 103, 60, 126, 80, 126, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (593, 12, NULL, 75, 80, 55, 25, 35, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (594, 12, NULL, 85, 105, 85, 40, 50, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (595, 12, NULL, 105, 140, 95, 55, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (596, 6, NULL, 50, 50, 40, 50, 40, 64)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (597, 6, 10, 75, 65, 55, 65, 55, 69)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (598, 6, 10, 105, 95, 75, 85, 75, 74)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (599, 12, NULL, 120, 100, 85, 30, 85, 45)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (600, 12, NULL, 75, 125, 75, 30, 75, 85)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (601, 7, 1, 45, 53, 70, 40, 60, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (602, 7, 1, 55, 63, 90, 50, 80, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (603, 7, 1, 75, 103, 80, 70, 80, 92)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (604, 7, 2, 30, 45, 59, 30, 39, 57)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (605, 7, 2, 40, 55, 99, 40, 79, 47)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (606, 7, 2, 60, 100, 89, 55, 69, 112)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (607, 1, 11, 40, 27, 60, 37, 50, 66)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (608, 1, 11, 60, 67, 85, 77, 75, 116)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (609, 1, NULL, 45, 35, 50, 70, 50, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (610, 1, NULL, 70, 60, 75, 110, 75, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (611, 6, NULL, 70, 92, 65, 80, 55, 98)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (612, 10, 18, 50, 72, 35, 35, 35, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (613, 10, 18, 60, 82, 45, 45, 45, 74)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (614, 10, 18, 95, 117, 80, 65, 70, 92)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (615, 3, NULL, 70, 90, 45, 15, 45, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (616, 3, NULL, 105, 140, 55, 30, 55, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (617, 3, 13, 105, 30, 105, 140, 105, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (618, 1, NULL, 75, 86, 67, 106, 67, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (619, 7, 14, 50, 65, 85, 35, 35, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (620, 7, 14, 70, 95, 125, 65, 75, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (621, 18, 12, 50, 75, 70, 35, 70, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (622, 18, 12, 65, 90, 115, 45, 115, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (623, 13, 4, 72, 58, 80, 103, 80, 97)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (624, 17, NULL, 38, 30, 85, 55, 65, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (625, 17, NULL, 58, 50, 145, 95, 105, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (626, 6, 14, 54, 78, 103, 53, 45, 22)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (627, 6, 14, 74, 108, 133, 83, 65, 32)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (628, 14, 4, 55, 112, 45, 74, 45, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (629, 14, 4, 75, 140, 65, 112, 65, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (630, 2, NULL, 50, 50, 62, 40, 62, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (631, 2, NULL, 80, 95, 82, 60, 82, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (632, 18, NULL, 40, 65, 40, 80, 40, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (633, 18, NULL, 60, 105, 60, 120, 60, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (634, 8, NULL, 55, 50, 40, 40, 40, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (635, 8, NULL, 75, 95, 60, 65, 60, 115)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (636, 13, NULL, 45, 30, 50, 55, 65, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (637, 13, NULL, 60, 45, 70, 75, 85, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (638, 13, NULL, 70, 55, 95, 95, 110, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (639, 13, NULL, 45, 30, 40, 105, 50, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (640, 13, NULL, 65, 40, 50, 125, 60, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (641, 13, NULL, 110, 65, 75, 125, 85, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (642, 6, 4, 62, 44, 50, 44, 50, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (643, 6, 4, 75, 87, 63, 87, 63, 98)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (644, 16, NULL, 36, 50, 50, 65, 60, 44)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (645, 16, NULL, 51, 65, 65, 80, 75, 59)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (646, 16, NULL, 71, 95, 85, 110, 95, 79)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (647, 8, 1, 60, 60, 50, 40, 50, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (648, 8, 1, 80, 100, 70, 60, 70, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (649, 9, 4, 55, 75, 60, 75, 60, 103)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (650, 7, NULL, 50, 75, 45, 40, 45, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (651, 7, 15, 70, 135, 105, 60, 105, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (652, 1, 2, 69, 55, 45, 55, 55, 15)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (653, 1, 2, 114, 85, 70, 85, 80, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (654, 6, 17, 55, 40, 50, 65, 85, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (655, 6, 17, 100, 60, 70, 85, 105, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (656, 6, NULL, 165, 75, 80, 40, 45, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (657, 7, 9, 50, 47, 50, 57, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (658, 7, 9, 70, 77, 60, 97, 60, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (659, 1, 15, 44, 50, 91, 24, 86, 10)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (660, 1, 15, 74, 94, 131, 54, 116, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (661, 15, NULL, 40, 55, 70, 45, 60, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (662, 15, NULL, 60, 80, 95, 70, 85, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (663, 15, NULL, 60, 100, 115, 70, 85, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (664, 9, NULL, 35, 55, 40, 45, 40, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (665, 9, NULL, 65, 85, 70, 75, 70, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (666, 9, NULL, 85, 115, 80, 105, 80, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (667, 13, NULL, 55, 55, 55, 85, 55, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (668, 13, NULL, 75, 75, 75, 125, 95, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (669, 17, 3, 50, 30, 55, 65, 55, 20)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (670, 17, 3, 60, 40, 60, 95, 60, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (671, 17, 3, 60, 55, 90, 145, 90, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (672, 5, NULL, 46, 87, 60, 30, 40, 57)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (673, 5, NULL, 66, 117, 70, 40, 50, 67)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (674, 5, NULL, 76, 147, 90, 60, 70, 97)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (675, 16, NULL, 55, 70, 40, 60, 40, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (676, 16, NULL, 95, 110, 80, 70, 80, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (677, 16, NULL, 70, 50, 30, 95, 135, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (678, 7, NULL, 50, 40, 85, 40, 65, 25)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (679, 7, NULL, 80, 70, 40, 100, 60, 145)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (680, 10, 9, 109, 66, 84, 81, 99, 32)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (681, 12, NULL, 45, 85, 50, 55, 50, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (682, 12, NULL, 65, 125, 60, 95, 60, 105)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (683, 5, NULL, 77, 120, 90, 60, 90, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (684, 10, 17, 59, 74, 50, 35, 50, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (685, 10, 17, 89, 124, 80, 55, 80, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (686, 18, 15, 45, 85, 70, 40, 40, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (687, 18, 15, 65, 125, 100, 60, 70, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (688, 8, NULL, 95, 110, 95, 40, 95, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (689, 8, 4, 70, 83, 50, 37, 50, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (690, 8, 4, 100, 123, 75, 57, 75, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (691, 18, 4, 70, 55, 75, 45, 65, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (692, 18, 4, 110, 65, 105, 55, 95, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (693, 3, NULL, 85, 97, 66, 105, 66, 65)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (694, 7, 15, 58, 109, 112, 48, 48, 109)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (695, 18, 5, 52, 65, 50, 45, 50, 38)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (696, 18, 5, 72, 85, 70, 65, 70, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (697, 18, 5, 92, 105, 90, 125, 90, 98)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (698, 7, 3, 55, 85, 55, 50, 55, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (699, 7, 3, 85, 60, 65, 135, 105, 100)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (700, 15, 12, 91, 90, 129, 90, 72, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (701, 14, 12, 91, 129, 90, 72, 90, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (702, 1, 12, 91, 90, 72, 90, 129, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (703, 4, NULL, 79, 115, 70, 125, 80, 111)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (704, 4, NULL, 79, 100, 80, 110, 90, 121)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (705, 9, 4, 79, 115, 70, 125, 80, 111)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (706, 9, 4, 79, 105, 70, 145, 80, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (707, 5, 3, 100, 120, 100, 150, 120, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (708, 5, 9, 100, 150, 120, 120, 100, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (709, 10, 4, 89, 125, 90, 115, 80, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (710, 10, 4, 89, 145, 90, 105, 80, 91)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (711, 5, 16, 125, 130, 90, 130, 90, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (712, 5, 16, 125, 170, 100, 120, 90, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (713, 5, 16, 125, 120, 90, 170, 100, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (714, 6, 12, 91, 72, 90, 129, 90, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (715, 6, 12, 91, 72, 90, 129, 90, 108)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (716, 8, 13, 100, 77, 77, 128, 128, 90)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (717, 8, 12, 100, 128, 90, 77, 77, 128)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (718, 7, 15, 71, 120, 95, 120, 95, 99)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (719, 1, NULL, 56, 61, 65, 48, 45, 38)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (720, 1, NULL, 61, 78, 95, 56, 58, 57)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (721, 1, 12, 88, 107, 122, 74, 75, 64)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (722, 3, NULL, 40, 45, 40, 62, 60, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (723, 3, NULL, 59, 59, 58, 90, 70, 73)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (724, 3, 13, 75, 69, 72, 114, 100, 104)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (725, 6, NULL, 41, 56, 40, 62, 44, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (726, 6, NULL, 54, 63, 52, 83, 56, 97)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (727, 6, 18, 72, 95, 67, 103, 71, 122)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (728, 8, NULL, 38, 36, 38, 32, 36, 57)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (729, 8, 10, 85, 56, 77, 50, 77, 78)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (730, 8, 4, 45, 50, 43, 40, 38, 62)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (731, 3, 4, 62, 73, 55, 56, 52, 84)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (732, 3, 4, 78, 81, 71, 74, 69, 126)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (733, 7, NULL, 38, 35, 40, 27, 25, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (734, 7, NULL, 45, 22, 60, 27, 30, 29)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (735, 7, 4, 80, 52, 50, 90, 50, 89)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (736, 3, 8, 62, 50, 58, 73, 54, 72)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (737, 3, 8, 86, 68, 72, 109, 66, 106)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (738, 11, NULL, 44, 38, 39, 61, 79, 42)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (739, 11, NULL, 54, 45, 47, 75, 98, 52)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (740, 11, NULL, 78, 65, 68, 112, 154, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (741, 1, NULL, 66, 65, 48, 62, 57, 52)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (742, 1, NULL, 123, 100, 62, 97, 81, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (743, 12, NULL, 67, 82, 62, 46, 48, 43)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (744, 12, 18, 95, 124, 78, 69, 71, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (745, 8, NULL, 75, 80, 60, 65, 90, 102)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (746, 13, NULL, 62, 48, 54, 63, 60, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (747, 13, NULL, 74, 48, 76, 83, 81, 104)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (748, 13, NULL, 74, 48, 76, 83, 81, 104)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (749, 15, 17, 45, 80, 100, 35, 37, 28)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (750, 15, 17, 59, 110, 150, 45, 49, 35)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (751, 15, 17, 60, 150, 50, 150, 50, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (752, 15, 17, 60, 50, 150, 50, 150, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (753, 11, NULL, 78, 52, 60, 63, 65, 23)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (754, 11, NULL, 101, 72, 72, 99, 89, 29)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (755, 11, NULL, 62, 48, 66, 59, 57, 49)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (756, 11, NULL, 82, 80, 86, 85, 75, 72)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (757, 18, 13, 53, 54, 53, 37, 46, 45)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (758, 18, 13, 86, 92, 88, 68, 75, 73)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (759, 14, 6, 42, 52, 67, 39, 56, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (760, 14, 6, 72, 105, 115, 54, 86, 68)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (761, 2, 6, 50, 60, 60, 60, 60, 30)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (762, 2, 5, 65, 75, 90, 97, 123, 44)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (763, 6, NULL, 50, 53, 62, 58, 63, 44)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (764, 6, NULL, 71, 73, 88, 120, 89, 59)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (765, 9, 8, 44, 38, 33, 61, 43, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (766, 9, 8, 62, 55, 52, 109, 94, 109)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (767, 14, 5, 58, 89, 77, 45, 45, 48)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (768, 14, 5, 82, 121, 119, 69, 59, 71)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (769, 14, 16, 77, 59, 50, 67, 63, 46)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (770, 14, 16, 123, 77, 72, 99, 92, 58)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (771, 11, NULL, 95, 65, 65, 110, 130, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (772, 12, 4, 78, 92, 75, 74, 63, 118)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (773, 9, 11, 67, 58, 57, 81, 67, 101)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (774, 14, 11, 50, 50, 150, 50, 150, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (775, 5, NULL, 45, 50, 35, 55, 75, 40)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (776, 5, NULL, 68, 75, 53, 83, 113, 60)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (777, 5, NULL, 90, 100, 70, 110, 150, 80)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (778, 15, 11, 57, 80, 91, 80, 87, 75)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (779, 17, 1, 43, 70, 48, 50, 60, 38)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (780, 17, 1, 85, 110, 76, 65, 82, 56)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (781, 17, 1, 49, 66, 70, 44, 55, 51)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (782, 17, 1, 44, 66, 70, 44, 55, 56)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (783, 17, 1, 54, 66, 70, 44, 55, 46)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (784, 17, 1, 59, 66, 70, 44, 55, 41)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (785, 17, 1, 65, 90, 122, 58, 75, 84)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (786, 17, 1, 55, 85, 122, 58, 75, 99)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (787, 17, 1, 75, 95, 122, 58, 75, 69)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (788, 17, 1, 85, 100, 122, 58, 75, 54)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (789, 16, NULL, 55, 69, 85, 32, 35, 28)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (790, 16, NULL, 95, 117, 184, 44, 46, 28)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (791, 4, 5, 40, 30, 35, 45, 40, 55)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (792, 4, 5, 85, 70, 80, 97, 80, 123)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (793, 11, NULL, 126, 131, 95, 131, 98, 99)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (794, 18, 4, 126, 131, 95, 131, 98, 99)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (795, 5, 10, 108, 100, 121, 81, 95, 95)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (796, 14, 11, 50, 100, 150, 100, 150, 50)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (797, 14, 11, 50, 160, 110, 160, 110, 110)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (798, 13, 17, 80, 110, 60, 150, 130, 70)
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (799, 13, 18, 80, 160, 60, 170, 130, 80)
GO
INSERT [dbo].[PokemonStatistic] ([ID], [Type1_ID], [Type2_ID], [HP], [Attack], [Defense], [Sp_Atk], [Sp_Def], [Speed]) VALUES (800, 3, 6, 80, 110, 120, 130, 90, 70)
SET IDENTITY_INSERT [dbo].[PokemonStatistic] OFF
GO
SET IDENTITY_INSERT [dbo].[Type] ON 

INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (1, N'Grass', N'7AC74C')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (2, N'Poison', N'A33EA1')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (3, N'Fire', N'EE8130')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (4, N'Flying', N'A98FF3')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (5, N'Dragon', N'6F35FC')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (6, N'Water', N'6390F0')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (7, N'Bug', N'A6B91A')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (8, N'Normal', N'A8A77A')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (9, N'Electric', N'F7D02C')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (10, N'Ground', N'E2BF65')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (11, N'Fairy', N'D685AD')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (12, N'Fighting', N'C22E28')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (13, N'Psychic', N'F95587')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (14, N'Rock', N'B6A136')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (15, N'Steel', N'B7B7CE')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (16, N'Ice', N'96D9D6')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (17, N'Ghost', N'735797')
INSERT [dbo].[Type] ([ID], [Name], [HexColor]) VALUES (18, N'Dark', N'705746')
SET IDENTITY_INSERT [dbo].[Type] OFF
GO
ALTER TABLE [dbo].[Pokemon]  WITH CHECK ADD  CONSTRAINT [FK_Generation_ID] FOREIGN KEY([Generation_ID])
REFERENCES [dbo].[Generation] ([ID])
GO
ALTER TABLE [dbo].[Pokemon] CHECK CONSTRAINT [FK_Generation_ID]
GO
ALTER TABLE [dbo].[Pokemon]  WITH CHECK ADD  CONSTRAINT [FK_Stats_ID] FOREIGN KEY([Stats_ID])
REFERENCES [dbo].[PokemonStatistic] ([ID])
GO
ALTER TABLE [dbo].[Pokemon] CHECK CONSTRAINT [FK_Stats_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic]  WITH CHECK ADD  CONSTRAINT [FK_Type1_ID] FOREIGN KEY([Type1_ID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[PokemonStatistic] CHECK CONSTRAINT [FK_Type1_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic]  WITH CHECK ADD  CONSTRAINT [FK_Type2_ID] FOREIGN KEY([Type2_ID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[PokemonStatistic] CHECK CONSTRAINT [FK_Type2_ID]
GO
/****** Object:  StoredProcedure [dbo].[sp_FilteredPokemon]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_FilteredPokemon]
	-- Add the parameters for the stored procedure here
	@Type nvarchar(50),
	@GenNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @Type IS NOT NULL AND @GenNum IS NOT NULL
	BEGIN
		SELECT *
		FROM [dbo].[vw_PokemonFull] a
		WHERE (a.Type_1 = @Type OR a.Type_2 = @Type) AND a.Generation_Number = @GenNum
	END

	IF @Type IS NOT NULL AND @GenNum IS NULL
	BEGIN
		SELECT *
		FROM [dbo].[vw_PokemonFull] a
		WHERE a.Type_1 = @Type OR a.Type_2 = @Type
	END

	IF @Type IS NULL AND @GenNum IS NOT NULL
	BEGIN
		SELECT *
		FROM [dbo].[vw_PokemonFull] a
		WHERE a.Generation_Number = @GenNum
	END

	IF @Type IS NULL AND @GenNum IS NULL
	BEGIN
		SELECT *
		FROM [dbo].[vw_PokemonFull] 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllRegions]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllRegions]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Generation_Number, Region_Name AS Name FROM Generation
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllTypes]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllTypes]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Name, HexColor FROM Type
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGenerationChartData]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGenerationChartData]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT(Region_Name) AS x, COUNT(Name) AS y, Generation_Number
	FROM vw_PokemonFull
	GROUP BY Region_Name, Generation_Number
	ORDER BY Generation_Number, Region_Name
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTypeChartData]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTypeChartData]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Distinct(Type_1) AS x, AVG(HP + Attack + Defense + Sp_Atk + Sp_Def + Speed) AS y
	FROM vw_PokemonFull
	GROUP BY Type_1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPokemon]    Script Date: 12/12/2022 11:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertPokemon]
	-- Add the parameters for the stored procedure here
	@Pokedex_Number int,
	@Name nvarchar(50),
	@Type1 nvarchar(50),
	@Type2 nvarchar(50),
	@HP int,
	@Attack int,
	@Defense int,
	@SPATK int,
	@SPDEF int,
	@Speed int,
	@Generation int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @T1_ID int
	DECLARE @T2_ID int
	DECLARE @Stat_ID int
	

    IF NOT EXISTS (SELECT Name FROM Type
					WHERE Name = @Type1)
					BEGIN
					INSERT INTO Type (Name)
					VALUES (@Type1)
					END

	SELECT @T1_ID = ID FROM Type
	WHERE Name = @Type1

	IF NULLIF(@Type2, '') IS NOT NULL AND @Type2 IS NOT NULL 
	BEGIN
		IF NOT EXISTS (SELECT Name FROM Type
						WHERE Name = @Type2)
						BEGIN
						INSERT INTO Type (Name)
						VALUES (@Type2)
						END

		SELECT @T2_ID = ID FROM Type
		WHERE Name = @Type2
	END

	INSERT INTO PokemonStatistic (Type1_ID, Type2_ID, HP, Attack, Defense, Sp_Atk, Sp_Def, Speed)
	VALUES (@T1_ID, @T2_ID, @HP, @Attack, @Defense, @SPATK, @SPDEF, @Speed)
	
	SELECT @Stat_ID = MAX(ID) FROM PokemonStatistic

	INSERT INTO Pokemon (Pokedex_Number, Name, Stats_ID, Generation_ID)
	VALUES (@Pokedex_Number, @Name, @Stat_ID, @Generation)
	

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 198
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullStats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullStats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 136
               Right = 429
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PokemonFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PokemonFull'
GO
