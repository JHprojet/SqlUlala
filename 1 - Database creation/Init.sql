-----------------------
-- DATABASE CREATION --
-----------------------

CREATE DATABASE UlalaStrat
GO

---------------------
-- TABLES CREATION --
---------------------

USE UlalaStrat;
GO

BEGIN TRANSACTION

CREATE TABLE Bosses (
	Id int IDENTITY,
	NameFR VARCHAR(50) NOT NULL,
	NameEN VARCHAR(50) NOT NULL,
	Active int DEFAULT 1 NOT NULL
);
ALTER TABLE Bosses ADD CONSTRAINT PK_Bosses PRIMARY KEY (Id)
GO 

CREATE TABLE Zones (
	Id int IDENTITY,
	ContinentFR VARCHAR(50) NOT NULL,
	ContinentEN VARCHAR(50) NOT NULL,
	ZoneFR VARCHAR(50) NOT NULL,
	ZoneEN VARCHAR(50) NOT NULL,
	ZoneQty int,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Zones ADD CONSTRAINT PK_Zones PRIMARY KEY (Id)
GO 

CREATE TABLE BossesPerZones (
	Id int IDENTITY,
	ZoneId int NOT NULL,
	BossId int NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE BossesPerZones ADD CONSTRAINT PK_BossesPerZones PRIMARY KEY (Id)
ALTER TABLE BossesPerZones ADD CONSTRAINT FK_Zones_BossesPerZones FOREIGN KEY (ZoneId) REFERENCES Zones(Id)
ALTER TABLE BossesPerZones ADD CONSTRAINT FK_Bosses_BossesPerZones FOREIGN KEY (BossId) REFERENCES Bosses(Id)
GO 

CREATE TABLE Users (
	Id int IDENTITY,
	Username VARCHAR(20) NOT NULL UNIQUE,
	Mail VARCHAR(100) NOT NULL UNIQUE,
	Password VARCHAR(100) NOT NULL,
	Role VARCHAR(20) NOT NULL,
	ActivationToken VARCHAR(MAX),
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Users ADD CONSTRAINT PK_Users PRIMARY KEY (Id)
ALTER TABLE Users ADD CONSTRAINT CHK_Users_Role CHECK (Role = 'Admin' OR Role = 'User')
GO 

CREATE TABLE Classes (
	Id int IDENTITY,
	NameFR VARCHAR(50) NOT NULL,
	NameEN VARCHAR(50) NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Classes ADD CONSTRAINT PK_Classes PRIMARY KEY (Id)
GO

CREATE TABLE CharactersConfigurations (
	Id int IDENTITY,
	ClasseId1 int NOT NULL,
	ClasseId2 int NOT NULL,
	ClasseId3 int NOT NULL,
	ClasseId4 int NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE CharactersConfigurations ADD CONSTRAINT PK_CharactersConfigurations PRIMARY KEY (Id)
ALTER TABLE CharactersConfigurations ADD CONSTRAINT FK_Classe1_CharactersConfigurations FOREIGN KEY (ClasseId1) REFERENCES Classes(Id)
ALTER TABLE CharactersConfigurations ADD CONSTRAINT FK_Classe2_CharactersConfigurations FOREIGN KEY (ClasseId2) REFERENCES Classes(Id)
ALTER TABLE CharactersConfigurations ADD CONSTRAINT FK_Classe3_CharactersConfigurations FOREIGN KEY (ClasseId3) REFERENCES Classes(Id)
ALTER TABLE CharactersConfigurations ADD CONSTRAINT FK_Classe4_CharactersConfigurations FOREIGN KEY (ClasseId4) REFERENCES Classes(Id)
GO

CREATE TABLE Skills (
	Id int IDENTITY,
	NameFR VARCHAR(100) NOT NULL,
	NameEN VARCHAR(100) NOT NULL,
	DescriptionFR VARCHAR(MAX) NOT NULL,
	DescriptionEN VARCHAR(MAX) NOT NULL,
	Location VARCHAR(MAX) NOT NULL,
	Cost INT NOT NULL,
	ClasseId INT,
	ImagePath VARCHAR(MAX),
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Skills ADD CONSTRAINT PK_Skills PRIMARY KEY (Id)
ALTER TABLE Skills ADD CONSTRAINT FK_Classes_Skills FOREIGN KEY (ClasseId) REFERENCES Skills(Id)
GO 

CREATE TABLE Strategies (
	Id int IDENTITY,
	UserId int NOT NULL,
	BossZoneId int NOT NULL,
	CharactersConfigurationId int NOT NULL,
	ImagePath1 VARCHAR(MAX) NOT NULL,
	ImagePath2 VARCHAR(MAX) NOT NULL,
	ImagePath3 VARCHAR(MAX) NOT NULL,
	ImagePath4 VARCHAR(MAX) NOT NULL,
	Note int,
	Comments VARCHAR(MAX),
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Strategies ADD CONSTRAINT PK_Strategies PRIMARY KEY (Id)
ALTER TABLE Strategies ADD CONSTRAINT FK_Users_Strategies FOREIGN KEY (UserId) REFERENCES Users(Id)
ALTER TABLE Strategies ADD CONSTRAINT FK_BossesPerZones_Strategies FOREIGN KEY (BossZoneId) REFERENCES BossesPerZones (Id)
ALTER TABLE Strategies ADD CONSTRAINT FK_CharactersConfigurations_Strategies FOREIGN KEY (CharactersConfigurationId) REFERENCES CharactersConfigurations(Id)
ALTER TABLE Strategies ADD CONSTRAINT CHK_Note_Strategies CHECK (Note >= 0)
GO 

CREATE TABLE FavoriteStrategies (
	Id int IDENTITY,
	UserId int NOT NULL,
	StrategyId int NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE FavoriteStrategies ADD CONSTRAINT PK_FavoriteStrategies PRIMARY KEY (Id)
ALTER TABLE FavoriteStrategies ADD CONSTRAINT FK_Users_FavoriteStrategies FOREIGN KEY (UserId) REFERENCES Users(Id)
ALTER TABLE FavoriteStrategies ADD CONSTRAINT FK_Strategies_FavoriteStrategies FOREIGN KEY (StrategyId) REFERENCES Strategies(Id)
GO 

CREATE TABLE Teams (
	Id int IDENTITY,
	UserId int NOT NULL,
	ZoneId int NOT NULL,
	CharactersConfigurationId int NOT NULL,
	TeamName VARCHAR(25) NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Teams ADD CONSTRAINT PK_Teams PRIMARY KEY (Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Users_Teams FOREIGN KEY (UserId) REFERENCES Users(Id)
ALTER TABLE Teams ADD CONSTRAINT FK_CharactersConfigurations_Teams FOREIGN KEY (CharactersConfigurationId) REFERENCES CharactersConfigurations(Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Zones_Teams FOREIGN KEY (ZoneId) REFERENCES Zones(Id)
GO 

CREATE TABLE Toys (
	Id int IDENTITY,
	NameFR VARCHAR(50) NOT NULL,
	NameEN VARCHAR(50) NOT NULL,
	ImagePath VARCHAR(MAX) NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Toys ADD CONSTRAINT PK_Toys PRIMARY KEY (Id)
GO

CREATE TABLE Votes (
	Id int IDENTITY,
	StrategyId int NOT NULL,
	UserId int NOT NULL,
	Vote int NOT NULL,
	Active int DEFAULT 1 NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Votes ADD CONSTRAINT PK_Votes PRIMARY KEY (Id)
ALTER TABLE Votes ADD CONSTRAINT FK_Users_Votes FOREIGN KEY (UserId) REFERENCES Users(Id)
ALTER TABLE Votes ADD CONSTRAINT FK_Strategies_Votes FOREIGN KEY (StrategyId) REFERENCES Strategies (Id)
ALTER TABLE Votes ADD CONSTRAINT CHK_Vote CHECK (Vote = -1 OR Vote = 0 OR Vote = 1)
GO

CREATE TABLE Follow (
	Id int IDENTITY,
	FollowerId int NOT NULL,
	FollowedId int NOT NULL,
	CreationDate date DEFAULT GETDATE() NOT NULL,
	LastUpdateDate date DEFAULT NULL
);
ALTER TABLE Follow ADD CONSTRAINT PK_Follow PRIMARY KEY (Id)
ALTER TABLE Follow ADD CONSTRAINT FK_Users_Followed FOREIGN KEY (FollowedId) REFERENCES Users (Id)
ALTER TABLE Follow ADD CONSTRAINT FK_Users_Follower FOREIGN KEY (FollowerId) REFERENCES Users (Id)
GO

COMMIT TRANSACTION