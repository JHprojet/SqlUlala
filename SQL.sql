-------------------
-- REMISE A ZERO --
-------------------

USE Master

DROP DATABASE Ulala
GO

-----------------------------
-- CREATION BASE DE DONNEE --
-----------------------------

CREATE DATABASE Ulala
GO
---------------------
-- CREATION TABLES --
---------------------

USE Ulala;  
GO

BEGIN TRANSACTION

CREATE TABLE Boss (
	Id int IDENTITY,
	NomFR VARCHAR(50) NOT NULL,
	NomEN VARCHAR(50) NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Boss ADD CONSTRAINT PK_Boss PRIMARY KEY (Id)
GO 

CREATE TABLE Zones (
	Id int IDENTITY,
	ContinentFR VARCHAR(50) NOT NULL,
	ContinentEN VARCHAR(50) NOT NULL,
	ZoneFR VARCHAR(50) NOT NULL,
	ZoneEN VARCHAR(50) NOT NULL,
	NbZones int,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Zones ADD CONSTRAINT PK_Zones PRIMARY KEY (Id)
GO 

CREATE TABLE BossZones (
	Id int IDENTITY,
	ZoneId int NOT NULL,
	BossId int NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE BossZones ADD CONSTRAINT PK_BossZones PRIMARY KEY (Id)
ALTER TABLE BossZones ADD CONSTRAINT FK_Zones_BossZones FOREIGN KEY (ZoneId) REFERENCES Zones(Id)
ALTER TABLE BossZones ADD CONSTRAINT FK_Boss_BossZones FOREIGN KEY (BossId) REFERENCES Boss(Id)
GO 

CREATE TABLE Utilisateurs (
	Id int IDENTITY,
	Pseudo VARCHAR(20) NOT NULL UNIQUE,
	Mail VARCHAR(100) NOT NULL UNIQUE,
	Password VARCHAR(100) NOT NULL, -- CHANGER EN VARBINARY AVANT TEST PLUS APPROFONDI
	Role VARCHAR(20) NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Utilisateurs ADD CONSTRAINT PK_Utilisateurs PRIMARY KEY (Id)
ALTER TABLE Utilisateurs ADD CONSTRAINT CHK_Utilisateurs_Role CHECK (Role = 'Admin' OR Role = 'User')
GO 

CREATE TABLE Classes (
	Id int IDENTITY,
	NomFR VARCHAR(50) NOT NULL,
	NomEN VARCHAR(50) NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Classes ADD CONSTRAINT PK_Classes PRIMARY KEY (Id)
GO

CREATE TABLE Teams (
	Id int IDENTITY,
	ClasseId1 int NOT NULL,
	ClasseId2 int NOT NULL,
	ClasseId3 int NOT NULL,
	ClasseId4 int NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Teams ADD CONSTRAINT PK_Teams PRIMARY KEY (Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Classe1_Teams FOREIGN KEY (ClasseId1) REFERENCES Classes(Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Classe2_Teams FOREIGN KEY (ClasseId2) REFERENCES Classes(Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Classe3_Teams FOREIGN KEY (ClasseId3) REFERENCES Classes(Id)
ALTER TABLE Teams ADD CONSTRAINT FK_Classe4_Teams FOREIGN KEY (ClasseId4) REFERENCES Classes(Id)
GO

CREATE TABLE Skills (
	Id int IDENTITY,
	NomFR VARCHAR(100) NOT NULL,
	NomEN VARCHAR(100) NOT NULL,
	ClasseId INT,
	ImagePath VARCHAR(MAX),
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Skills ADD CONSTRAINT PK_Skills PRIMARY KEY (Id)
ALTER TABLE Skills ADD CONSTRAINT FK_Classes_Skills FOREIGN KEY (ClasseId) REFERENCES Skills (Id)
GO 

CREATE TABLE Enregistrements (
	Id int IDENTITY,
	UtilisateurId int NOT NULL,
	BossZoneId int NOT NULL,
	TeamId int NOT NULL,
	ImagePath1 VARCHAR(MAX) NOT NULL,
	ImagePath2 VARCHAR(MAX) NOT NULL,
	ImagePath3 VARCHAR(MAX) NOT NULL,
	ImagePath4 VARCHAR(MAX) NOT NULL,
	Note int,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Enregistrements ADD CONSTRAINT PK_Enregistrements PRIMARY KEY (Id)
ALTER TABLE Enregistrements ADD CONSTRAINT FK_Utilisateurs_Enregistrements FOREIGN KEY (UtilisateurId) REFERENCES Utilisateurs (Id)
ALTER TABLE Enregistrements ADD CONSTRAINT FK_BossZones_Enregistrements FOREIGN KEY (BossZoneId) REFERENCES BossZones (Id)
ALTER TABLE Enregistrements ADD CONSTRAINT FK_Teams_Enregistrements FOREIGN KEY (TeamId) REFERENCES Teams (Id)
ALTER TABLE Enregistrements ADD CONSTRAINT CHK_Note_Enregistrements CHECK (Note >= 0)
GO 

CREATE TABLE Favoris (
	Id int IDENTITY,
	UtilisateurId int NOT NULL,
	EnregistrementId int NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Favoris ADD CONSTRAINT PK_Favoris PRIMARY KEY (Id)
ALTER TABLE Favoris ADD CONSTRAINT FK_Utilisateurs_Favoris FOREIGN KEY (UtilisateurId) REFERENCES Utilisateurs (Id)
ALTER TABLE Favoris ADD CONSTRAINT FK_Enregistrement_Favoris FOREIGN KEY (EnregistrementId) REFERENCES Enregistrements (Id)
GO 

CREATE TABLE MesTeams (
	Id int IDENTITY,
	UtilisateurId int NOT NULL,
	ZoneId int NOT NULL,
	TeamId int NOT NULL,
	NomTeam VARCHAR(25) NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE MesTeams ADD CONSTRAINT PK_MesTeams PRIMARY KEY (Id)
ALTER TABLE MesTeams ADD CONSTRAINT FK_Utilisateurs_MesTeams FOREIGN KEY (UtilisateurId) REFERENCES Utilisateurs (Id)
ALTER TABLE MesTeams ADD CONSTRAINT FK_Teams_MesTeams FOREIGN KEY (TeamId) REFERENCES Teams (Id)
ALTER TABLE MesTeams ADD CONSTRAINT FK_Zones_MesTeams FOREIGN KEY (ZoneId) REFERENCES Zones (Id)
GO 

CREATE TABLE Jouets (
	Id int IDENTITY,
	NomFR VARCHAR(50) NOT NULL,
	NomEN VARCHAR(50) NOT NULL,
	ImagePath VARCHAR(MAX) NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Jouets ADD CONSTRAINT PK_Jouets PRIMARY KEY (Id)
GO

CREATE TABLE Votes (
	Id int IDENTITY,
	EnregistrementId int NOT NULL,
	UtilisateurId int NOT NULL,
	Vote int NOT NULL,
	Actif int DEFAULT 1 NOT NULL
);
ALTER TABLE Votes ADD CONSTRAINT PK_Votes PRIMARY KEY (Id)
ALTER TABLE Votes ADD CONSTRAINT FK_Utilisateurs_Votes FOREIGN KEY (UtilisateurId) REFERENCES Utilisateurs (Id)
ALTER TABLE Votes ADD CONSTRAINT FK_Enregistrements_Votes FOREIGN KEY (EnregistrementId) REFERENCES Enregistrements (Id)
ALTER TABLE Votes ADD CONSTRAINT CHK_Vote CHECK (Vote = -1 OR Vote = 0 OR Vote = 1)
GO

COMMIT TRANSACTION

-----------------------
-- INSERTION DONNEES --
-----------------------

USE Ulala;  
GO 

BEGIN TRANSACTION

INSERT INTO Boss (NomEN, NomFR) VALUES ('T-Rex','T.Rex');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Black Rock T-Rex','T.Rex de Rochenoire');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Black-Haired King','Roi � Crini�re Noire');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Big Tongue Flower King','Fleur Linguiforme Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Sabre Tiger King','Smilodon Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Stegosaurus','St�gosaure');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Lightning T-Rex','T.Rex de Foudre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Dragon','Brontosaure');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Trasher','Talarurus');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Triceratops','Tric�ratops');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Unicorn Gorilla Chief','Gorille-Licorne en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Ankylosaur','Ankylosaure');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Blackrock Trasher','Talarurus de Rochenoire');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Golden Thunder Dragon','Brontosaure Chrysopt�re');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Wind Dragon','Dragon d''Eole');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Stegosaurus','St�gosaure de Tonnerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Ceratops','Tric�ratops de Tonnerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Pterosaur King','Pt�rosaure Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Bone Ankylosaur','Ankylosaure Osseux');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Giant Shell Turtle','Tortue G�ante');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Molten Stegosaurus','St�gosaure de Lave');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Lava Beast Chieftan','B�te de Lave en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Crimson Ceratops','Tric�ratops Roux');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Fire Ankylosaur','Ankylosaure de Feu');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Tyrant Dragon','Dragon-Tyran');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Sabre Tiger King & Grey Tiger King','Tigre Blanc Alpha & Smilodon Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('LionDragon','Dragon-Lion');
INSERT INTO Boss (NomEN, NomFR) VALUES ('T. Rex','T.Rex');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Warg King','Vargr Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Walrus Chieftain','Morse en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('White Unicorn Gorilla Chief','Gorilles-Licorne en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Cold Light Trasher','Talarurus de Froide Lumi�re');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Ice LionDragon','Dragon-Lion de Glace');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Yak King','Yak Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Brown Bear Chief','Ours Brun en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Mammoth','Mammouth');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Typhoon Dragon','Dragon-Typhon');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Irish Elk','Elan Irlandais');
INSERT INTO Boss (NomEN, NomFR) VALUES ('White Wolf King','Loup Blanc Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('White Yak King','Yak Blanc Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Polar Bear Chief','Ours Polaire en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Moon Wind Dragon','Dragon de Lunevent');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Queen Dragon','Dragon Reine');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Black Bear Chief','Ours Noir en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Syngnathus','Aiguille de Mer');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Rhino Chieftain','Rhinoc�ros en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Lightning Dimetrodon','Dim�trodon de Foudre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Radobaan','Radobaan');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Hermit Crab','Bernard-l''Hermite');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Giant Mountain Dragon','Dragon Montagnier G�ant');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Sand Frilled Lizard Chieftain','Parapluie de Sable');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Crimson Wolf King','Loux Roux Alpha');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Dinornis','Moa G�ant');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Dimetrodon','Dim�trodon');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Red Brown Bear Chief','Ours Brun et Roux en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Rock Placodermi','Placoderme de Roche');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Blade Rhino Chieftain','Rhinoc�ros � Lame en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Pangolin Chieftain','Pangolin en Chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Placodermi','Placoderme de Tonnerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Allosaurus','Allosaure');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Sharptalon dragon','Dragon griffu');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder narwhal king','Narval alpha de Tonerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Golden combed allosaurus','Allosaure chrysophore');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Allosaurus','Allosaurus de Tonerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Spinosaurus','Spinosaure');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Driller Chieftain','Perceur en chef');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Thunder Wolf King','Loup Alpha de Tonnerre');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Titanothere','Brontotheride');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Darknight Allosaurus','Allosaure Noctambule');
INSERT INTO Boss (NomEN, NomFR) VALUES ('AREMPLIR','Brontosaure argyroptere');
INSERT INTO Boss (NomEN, NomFR) VALUES ('Flame Scar-Bunny','Lapin balafr� de flammes');
-- OK -- MANQUE BOSS APRES ANCIENT RUINS ET UNE TRAD EN --
GO

INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Primitive Plain','Feu','Plaines Primitives','20');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Sabada Rainforest','Feu','For�t Tropicale de Sabada','60');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Chiwawa Gorge','Feu','Gorge de Chiwawa','100');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Bata Desert','Feu','D�sert de Bata','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Bababo Coast','Feu','C�te de Bababo','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Jujule Volcano','Feu','Volcan Jujule','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Sinbad Rainforest','Feu','For�t Tropicale de Sinbad','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Toto Plain','Feu','Plaines de Toto','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Fire','Cobo Coast','Feu','C�te de Cobo','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Horu Fjord','Gel�','Fjord de Horu','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Tintin Ice Cave','Gel�','Grotte de Glace de Tintin','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Tovana Snowland','Gel�','Terre Enneig�es de Tovana','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Puke Glacier','Gel�','Glacier de Puck','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Warry Woodland','Gel�','Bois de Warry','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Dodori Snow Mountain','Gel�','Montagne Enneig�e de Dodori','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Sinvasa Woodland','Gel�','Bois de Sinvasa','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Hori Fjord','Gel�','Fjord de Hori','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Frost','Puketa Glacier','Gel�','Glacier de Pucketa','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Totori Coast','Humus','C�te de Totori','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Girka Desert','Humus','Girka D�sert','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Paro Oasis','Humus','Oasis de Paro','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Karusa Salt Lake','Humus','Lac Sal� de Karusa','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Thousand Needles','Humus','Mille-Aiguilles','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Giant Rock Mountain','Humus','Montagne de Gros-Caillou','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Cora Gobi','Humus','D�sert de Cora','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Papeto Oasis','Humus','Oasis de Papeto','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Soil','Gysean Salt Lake','Humus','Lac Sal� de Gys�ens','120');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Giant falls coast','Fulminant','C�te des chutes g�antes','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Rabo sea','Fulminant','Mer de rabo','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Ancient ruins','Fulminant','Anciennes Ruines','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Arc Slope','Fulminant','Piedmont d''Arc','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Northeast Coast','Fulminant','C�te Nord-Est','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','East Ancient Ruins','Fulminant','Anciennes Ruines de l''orient','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Temple Forest','Fulminant','F�ret du Temple','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Giant Peak Forest','Fulminant','For�t du Pic G�ant','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Lightning','Storm Summit','Fulminant','Sommet des Temp�tes','200');
INSERT INTO Zones (ContinentEN, ZoneEN, ContinentFR, ZoneFR, NbZones) VALUES ('Event','World Event','Ev�nement','Ev�nement global','200');
-- OK -- ATTENTION MANQUES DES ZONES DANS LA LISTE (DANS FULMINANT) --
GO

INSERT INTO BossZones (ZoneId, BossId) VALUES ('1','1');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('1','2');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('1','3');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('1','4');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('2','4');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('2','5');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('2','6');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('2','7');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('3','8');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('3','9');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('3','10');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('3','11');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('3','12');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('4','12');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('4','13');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('4','14');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('4','15');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('4','16');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','16');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','17');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','18');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','19');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','20');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('5','21');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','21');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','22');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','1');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','23');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','24');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('6','25');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('7','8');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('7','4');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('7','26');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('7','11');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('8','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('8','3');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('8','28');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('8','29');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('8','26');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('9','30');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('9','20');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('9','19');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('9','16');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('9','17');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','31');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','32');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','34');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','35');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('10','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('11','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('11','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('11','37');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('11','38');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('11','39');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','40');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','31');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','39');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','32');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','41');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('12','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('13','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('13','34');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('13','35');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('13','38');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('13','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','31');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','39');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','41');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','37');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('14','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('15','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('15','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('15','40');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('15','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('15','43');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('16','44');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('16','38');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('16','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('16','34');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('16','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('17','36');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('17','34');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('17','44');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('17','40');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('17','31');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('18','33');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('18','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('18','37');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('18','41');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('18','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('19','45');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('19','46');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('19','2');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('19','15');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('19','47');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','15');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','48');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','49');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','50');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','51');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('20','52');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('21','52');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('21','53');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('21','54');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('21','10');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('21','12');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('22','55');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('22','53');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('22','56');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('22','48');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('22','45');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('23','50');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('23','51');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('23','57');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('23','52');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('23','49');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('24','58');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('24','12');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('24','50');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('24','48');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('25','49');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('25','51');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('25','58');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('25','13');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('25','47');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('26','58');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('26','10');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('26','54');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('26','57');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('26','13');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('27','53');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('27','45');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('27','2');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('27','56');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('27','55');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','59');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','60');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','61');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','16');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','62');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','20');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','63');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('28','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('29','59');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('29','62');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('29','20');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('29','63');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('29','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('30','60');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('30','65');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('30','66');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('30','42');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('30','68');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('31','69');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('31','14');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('31','67');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('31','17');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('31','59');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('32','59');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('32','17');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('32','65');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('32','67');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('32','20');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('33','66');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('33','63');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('33','27');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('33','69');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('33','70');
INSERT INTO BossZones (ZoneId, BossId) VALUES ('37','71');
-- OK -- MANQUE DES ASSOCIATIONS SUR LES ZONES ET BOSS MANQUANTS --
GO

INSERT INTO Classes (NomEN, NomFR) VALUES ('Warlock','Sorcier');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Assassin','Assassin');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Warrior','Guerrier');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Druid','Druide');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Mage','Mage');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Hunter','Chasseur');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Gladiator','Gladiateur');
INSERT INTO Classes (NomEN, NomFR) VALUES ('Shaman','Shaman');
-- OK
GO

INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Bone Ankylosaur','Ankilosaure Osseux','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('T. Rex','T. Rex','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Black Rock T. Rex','T. Rex RocheNoire','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Marmot','Marmotte','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Sabre Tiger King','Smilodon Alpha','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Black Moblin','Mobelin Noir','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Brown Bear','Ours Brun','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Walrus','Morse','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Irish Elk','Elan Irlandais','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Dimetrodon','Dim�trodon','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Queen Dragon','Dragon Reine','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Hermit Crab','Bernard-l''Ermite','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Sheep','Lainergie','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Unicorn Gorilla','Gorille-Licorne','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Narwhal','Narval Alpha','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Big Tong Flower','Fleur Linguiforme','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('White Camel','Chameau Blanc','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Yak King','Yak Alpha','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Moblin','Mobelin','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Dandelion','Pissenlit','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Wind Dragon','Dragon d''Eole','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Warg King','Vargr Alpha','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Triceratops','Tric�ratops','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Dodo Bird','Oiseau Dodo','AREMPLIR');
INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES ('Snow Marmot','Marmotte Enneign�e','AREMPLIR');
-- OK -- IMAGEPATH A REMPLIR
GO

INSERT INTO Utilisateurs (Mail, Password, Pseudo, Role) VALUES ('hercejulien@gmail.com','test','Coupain','Admin');
-- OK --
GO



-- Toutes les possibilit�s de teams diff�rentes
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','1');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','2');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('7','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('8','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','2');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','1','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','2');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','2','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','7','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('7','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('7','8','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','2');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('7','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','2','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','1','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','2','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','3');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','2','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','4','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','3','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','5','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','4','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','6','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','5','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','7','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','6','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','7','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('6','7','8','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','4');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','3','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','2','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','3','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','4','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','5','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('1','6','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','4','5');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','4','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','4','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','4','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','3','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','4','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','5','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('2','6','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','5','6');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','5','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','5','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','4','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','5','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('3','6','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','6','7');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','6','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','5','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('4','6','7','8');
INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES ('5','6','7','8');
GO

INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Ignite','Mise � Feu','~/Images/60px-Ignite.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Dragonfire','Sortil�ge de Flamme','~/Images/60px-Dragonfire.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Conflagrate','Explosion Incendiaire','~/Images/60px-Conflagrate.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Soul Twins','�mes Jumel�es','~/Images/60px-Soul_Twins.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Life Tap','Branche de Sant�','~/Images/60px-Life_Tap.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Polymorph: Frog','Sortil�ge de M�tamorphose en Grenouille aux gros yeux','~/Images/60px-Polymorph:_Frog.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Dehydration','D�shydratation','~/Images/60px-Dehydration.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Soul Lash','Lac�ration d''�me','~/Images/60px-Soul_Lash.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Summon Pharmacist Frog','Invocation Grenouille Pharmacienne','~/Images/60px-Summon_Pharmacist_Frog.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Drain','Succion','~/Images/60px-Drain.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Summon Elder Frog','Invocation Grenouille Ancienne','~/Images/60px-Summon_Elder_Frog.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Quack quack quack','Coin Coin','~/Images/60px-Quack_quack_quack.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Frog Synergy','Sortil�ge de Coop�ration amphibienne','~/Images/60px-Frog_Synergy.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Chain Ignition','Embrasement en Cha�ne','~/Images/60px-Chain_Ignition.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Soul Wave','Vague � l''�me','~/Images/60px-Soul_Wave.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Soul Seal','Sceau d''�me','~/Images/60px-Soul_Seal.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Painful Ignition','Br�lure Douloureuse','~/Images/60px-Painful_Ignition.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Multi-Ignition','Embrasement Multiple','~/Images/60px-Multi-Ignition.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Multi-Ignition II','Embrasement Multiple II','~/Images/60px-Multi-Ignition_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Soul Rebirth','Renaissance d''�me','~/Images/60px-Soul_Rebirth.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Incinerate','Terre Br�l�e','~/Images/60px-Incinerate.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('1','Summon Violent Frog','Invocation de Grenouille Violente','~/Images/60px-Summon_Violent_Frog.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Reckless Lunge','Plongeon t�m�raire','~/Images/60px-Reckless_Lunge.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Reverberating Slam','R�verb�ration percutante','~/Images/60px-Reverberating_Slam.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Reverberating Slam II','R�verb�ration percutante II','~/Images/60px-Reverberating_Slam_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Double Throw Knives','Cha�nes de poignards','~/Images/60px-Double_Throw_Knives.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Bounce bounce bounce','Bo�ng bo�ng bo�ng','~/Images/60px-Bounce_bounce_bounce.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Cloak of Bush','Cape Buissoni�re','~/Images/60px-Cloak_of_Bush.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Pounce','Bondir','~/Images/60px-Pounce.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Pursuing','Poursuite','~/Images/60px-Pursuing.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Roundhouse','Coup circulaire','~/Images/60px-Roundhouse.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Backstab','Epine dans le pied','~/Images/60px-Backstab.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Fan of Knives','Eventail de lames','~/Images/60px-Fan_of_Knives.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Scatter Blade','Lame de dispersion','~/Images/60px-Scatter_Blade.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Fatal Knife','Couteau de lancer mortel','~/Images/60px-Fatal_Knife.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Rupture','Rupture','~/Images/60px-Rupture.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Lacerations','Lac�rations','~/Images/60px-Lacerations.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Zeal','Z�le','~/Images/60px-Zeal.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Ambush','Embuscade','~/Images/60px-Ambush.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Poison Coat','Couche de poison','~/Images/60px-Poison_Coat.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Swiftwind Daggers','Dagues de volevent','~/Images/60px-Swiftwind_Daggers.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Fish Bone Throwing Knife','Poignard volant en ar�te','~/Images/60px-Fish_Bone_Throwing_Knife.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Mortal Wounds','Blessures mortelles','~/Images/60px-Mortal_Wounds.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('2','Shiv','Lame empoison�e','~/Images/60px-Shiv.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Resolution','R�solution','~/Images/60px-Resolution.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Swipe','Balayage','~/Images/60px-Swipe.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Bramble Shield','Bouclier de ronces','~/Images/60px-Bramble_Shield.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Fearless Shield','Bouclier intr�pide','~/Images/60px-Fearless_Shield.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Last Stand','Baroud d''honneur','~/Images/60px-Last_Stand.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Hoo Kham Kham','Hou kam kam','~/Images/60px-Hoo_Kham_Kham.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Protection Stance','Posture de protection','~/Images/60px-Protection_Stance.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Shield of Protection','Bouclier de protection','~/Images/60px-Shield_of_Protection.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Lion�s Roar','Rugissement l�onin','~/Images/60px-Lion�s_Roar.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Safeguard','Sauvegarde','~/Images/60px-Safeguard.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Safeguard II','Sauvegarde II','~/Images/60px-Safeguard_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Giant�s Return','Retour du g�ant','~/Images/60px-Giant�s_Return.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Hoo haha hah','Hou ha ha','~/Images/60px-Hoo_haha_hah.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Unbreakable Will','Volont� inflexible','~/Images/60px-Unbreakable_Will.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Powerful Knock Up','Violent coup de poing','~/Images/60px-Powerful_Knock_Up.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Call to Arms','Appel aux armes','~/Images/60px-Call_to_Arms.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Stockpile','Accumulation de puissance','~/Images/60px-Stockpile.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Final Blow','Coup de gr�ce','~/Images/60px-Final_Blow.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Overwhelming Assault','Assaut accablant','~/Images/60px-Overwhelming_Assault.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Come Here','Viens ici','~/Images/60px-Come_Here.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('3','Unwavering Will','Volon� indestructible','~/Images/60px-Unwavering_Will.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Mend','Rem�de','~/Images/60px-Mend.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Song of Life','Chant de Vide','~/Images/60px-Song_of_Life.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Seed of Replenishment','Graine Nourrici�re','~/Images/60px-Seed_of_Replenishment.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Quills','Plume Volante','~/Images/60px-Quills.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Quills II','Plume Volante II','~/Images/60px-Quills_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Purification Seed','Graine de Purification','~/Images/60px-Purification_Seed.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Lilly Transform','M�tamorphose de G�lule','~/Images/60px-Lilly_Transform.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Tree Ward','Barri�re Sylvestre','~/Images/60px-Tree_Ward.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Binding Heal','B�n�diction de Symbiose','~/Images/60px-Binding_Heal.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Flower Seed','Graine de Fleur','~/Images/60px-Flower_Seed.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Luna Blessing','B�n�diction de la Lune','~/Images/60px-Luna_Blessing.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Song of Protection','Chant de Protection','~/Images/60px-Song_of_Protection.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','The Seed of Life','Graine de Vie','~/Images/60px-The_Seed_of_Life.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Tranquility','Paix Universelle','~/Images/60px-Tranquility.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Force of Bud','Force Bourgeonnante','~/Images/60px-Force_of_Bud.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Life Bloom','Eclosion de vie','~/Images/60px-Life_Bloom.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Extended Healing','Force continue','~/Images/60px-Extended_Healing.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Revitalize Nature','Souffle universel','~/Images/60px-Revitalize_Nature.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Natural Aegis','Abri naturel','~/Images/60px-Natural_Aegis.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Ukaka Transform','M�tamorphose en Ukaka','~/Images/60px-Ukaka_Transform.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','New Bud','Nouveau Bourgeon','~/Images/60px-New_Bud.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('4','Quills Thrust','Estoc de plumme volante','~/Images/60px-Quills_Thrust.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Magic Blast','Explosion Magique','~/Images/60px-Magic_Blast.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Magic Intellect','Intellect Magique','~/Images/60px-Magic_Intellect.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Magic Intellect II','Intellect Magique II','~/Images/60px-Magic_Intellect_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Mirror Image','Reflet','~/Images/60px-Mirror_Image.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Meteorite','M�t�orite','~/Images/60px-Meteorite.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Lightning Wave','Vague Foudroyante','~/Images/60px-Lightning_Wave.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Fireball','Boule de Feu','~/Images/60px-Fireball.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Scorch','Br�lure Superficielle','~/Images/60px-Scorch.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Fire Blast','Explosion Ardente','~/Images/60px-Fire_Blast.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Purification Wave','Vague de purification','~/Images/60px-Purification_Wave.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Seal Storm','Temp�te Scell�e','~/Images/60px-Seal_Storm.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Terminal Storm','Temp�te Mortelle','~/Images/60px-Terminal_Storm.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Lightning Blast','Explosion Electrique','~/Images/60px-Lightning_Blast.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Serenity','Attention Ravie','~/Images/60px-Serenity.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Frost Missile','Missile de Givre','~/Images/60px-Frost_Missile.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Cone of Cold','Sortil�ge de Stalactite de Glace','~/Images/60px-Cone_of_Cold.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Frostbolt','Eclair de Givre','~/Images/60px-Frostbolt.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Magic Missiles','Missile Magique','~/Images/60px-Magic_Missiles.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Blizzard','Blizzard','~/Images/60px-Blizzard.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Forst Nova','Nova givr�e','~/Images/60px-Forst_Nova.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Magic Suppression','Oppression Magique','~/Images/60px-Magic_Suppression.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('5','Silence','Silence','~/Images/60px-Silence.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Storm Shot','Tir de temp�te','~/Images/60px-Storm_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Steady Shot','Tir stabilis�','~/Images/60px-Steady_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Arrow Barrage','Barrage de fl�che','~/Images/60px-Arrow_Barrage.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Multi-Shot','Un tir, deux fl�ches','~/Images/60px-Multi-Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Aspect of the Eagle','Ami des faucons','~/Images/60px-Aspect_of_the_Eagle.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Hawk Call � Sheen','Appel de Faucon - Eclat','~/Images/60px-Hawk_Call_�_Sheen.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Weakpoint Shot','Tir vuln�rant','~/Images/60px-Weakpoint_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Hawk Call � Gal','Appel de Faucon - Gal','~/Images/60px-Hawk_Call_�_Gal.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Hawk Call � Gal II','Appel de Faucon - Gal II','~/Images/60px-Hawk_Call_�_Gal_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Numbing Shot','Fl�che paralysante','~/Images/60px-Numbing_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Explosive Shot','Fl�che explosive','~/Images/60px-Explosive_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Burning Shot','Fl�che enflamm�e','~/Images/60px-Burning_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Scatter Shot','Fl�che d''annulation','~/Images/60px-Scatter_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Hawk Call � Pan','Appel de Faucon - Pan','~/Images/60px-Hawk_Call_�_Pan.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Sunder Armor Shot','Tir Fend-armure','~/Images/60px-Sunder_Armor_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Flaying Arrow','Fl�che de l''�corcheur','~/Images/60px-Flaying_Arrow.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Boar�s Rush','Charge du sanglier sauvage','~/Images/60px-Boar�s_Rush.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Aimed Shot','Tir ajust�','~/Images/60px-Aimed_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Piercing Shot','Tir p�n�trant','~/Images/60px-Piercing_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Quick Shot','Tir rapide','~/Images/60px-Quick_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Volley','Salve','~/Images/60px-Volley.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('6','Lunar Shot','Tir lunaire','~/Images/60px-Lunar_Shot.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Blood Howl','Hurlement Sanguinaire','~/Images/60px-Blood_Howl.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Whirlwind','Tourmente','~/Images/60px-Whirlwind.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Cleave','Fendoir','~/Images/60px-Cleave.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Toughen','Endurcissement','~/Images/60px-Toughen.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Boil Blood','Sang Bouillant','~/Images/60px-Boil_Blood.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Hoo Kham Kham','Hou Kam Kam','~/Images/60px-Hoo_Kham_Kham.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Barbarian Veins','Veine de Barbare','~/Images/60px-Barbarian_Veins.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Blood Force','Force Sanguinaire','~/Images/60px-Blood_Force.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Intercept','Interception','~/Images/60px-Intercept.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Sacrifice','Sacrifice','~/Images/60px-Sacrifice.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Sacrifice II','Sacrifice II','~/Images/60px-Sacrifice_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Rising Rage','Furie Ardente','~/Images/60px-Rising_Rage.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Hoo hoo hoo','Ouhou ouhou','~/Images/60px-Hoo_hoo_hoo.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Death Denied','Sain et Sauf','~/Images/60px-Death_Denied.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Uppercut','Uppercut','~/Images/60px-Uppercut.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Battle Shout','Cri du Berserker','~/Images/60px-Battle_Shout.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Let�s Charge','A l''Assaut','~/Images/60px-Let�s_Charge.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Bloody Combat','Combat Sanglant','~/Images/60px-Bloody_Combat.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Severing Strike','Perforation Coupante','~/Images/60px-Severing_Strike.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Frenzy','Fr�n�sie','~/Images/60px-Frenzy.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('7','Fevered Pursuit','Poursuite Enfi�vr�e','~/Images/60px-Fevered_Pursuit.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Raine Dance','Danse de la Pluie','~/Images/60px-Raine_Dance.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Riptide','Contre-Courant','~/Images/60px-Riptide.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Spring Totem','Totem du Printemps','~/Images/60px-Spring_Totem.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Drums of Purge','Tambours de Purge','~/Images/60px-Drums_of_Purge.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Electric Shock','Courant Electrique','~/Images/60px-Electric_Shock.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Ancestral Protection','Protection Ancestrale','~/Images/60px-Ancestral_Protection.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Faith Protection','Foi Protectrice','~/Images/60px-Faith_Protection.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Dance With Me','Danse Curative','~/Images/60px-Dance_With_Me.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Thunder Heart','Coeur de Tonnerre','~/Images/60px-Thunder_Heart.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Thunder Heart II','Coeur de Tonnerre II','~/Images/60px-Thunder_Heart_II.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Drums of Recovery','Tambours de R�cup�ration','~/Images/60px-Drums_of_Recovery.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Drums of Rain','Tambours de Pluie','~/Images/60px-Drums_of_Rain.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Ancestral Gift','Merci ancestrale','~/Images/60px-Ancestral_Gift.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Chain Heal','Cha�ne de Soins','~/Images/60px-Chain_Heal.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Blessing of Spirits','B�n�diction Ancestrale','~/Images/60px-Blessing_of_Spirits.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Font of Purge','Fontaine de Purification','~/Images/60px-Font_of_Purge.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Recovery Totem','Totem de R�cup�ration','~/Images/60px-Recovery_Totem.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Life Totem','Totem de Vie','~/Images/60px-Life_Totem.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Surge','D�ferlement','~/Images/60px-Surge.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Ancestral Aegis','Bouclier Ancestral','~/Images/60px-Ancestral_Aegis.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Fury of the Ancestors','Furie Ancestrale','~/Images/60px-Fury_of_the_Ancestors.png');
INSERT INTO Skills (ClasseId, NomEN, NomFR, ImagePath) VALUES ('8','Charm Dance','Danse Charmante','~/Images/60px-Charm_Dance.png');
GO

INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,58,5,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',3)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,2,182,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',5)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,4,112,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',8)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,8,152,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',20)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,10,172,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',22)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,12,142,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,15,142,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',0)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,20,162,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',0)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,22,162,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',4)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,21,142,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',5)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,30,112,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',8)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,32,122,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',7)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,33,127,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',9)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,36,127,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',7)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,40,128,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',4)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,42,129,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',2)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,58,124,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,48,121,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,50,124,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,52,125,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,51,127,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',8)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,54,128,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,60,128,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,62,112,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,67,112,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,70,212,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,56,212,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1,ImagePath2,ImagePath3,ImagePath4, Note) VALUES (1,84,312,'AREMPLIR','AREMPLIR','AREMPLIR','AREMPLIR',10)
GO

INSERT INTO MesTeams (UtilisateurId, TeamId, ZoneId, NomTeam) VALUES (1,5,3,'Team1')
INSERT INTO MesTeams (UtilisateurId, TeamId, ZoneId, NomTeam) VALUES (1,12,7,'Team2')
GO

INSERT INTO Votes (EnregistrementId, UtilisateurId, Vote) VALUES (2, 1, 1)
GO

INSERT INTO Favoris (EnregistrementId, UtilisateurId) VALUES (2, 1)
GO

COMMIT TRANSACTION

----------------------
-- CREATION DES VUE --
----------------------

USE Ulala;  
GO 

BEGIN TRANSACTION
GO
CREATE VIEW V_Enregistrements_FR AS SELECT U.Id as 'UtilisateurId', BZ.Id as 'BossZoneId', B.NomFR, Z.ContinentFR, Z.ZoneFR, C1.Id as 'IdClasse 1', C2.Id as 'IdClasse 2',C3.Id as 'IdClasse 3',C4.Id as 'IdClasse 4', C1.NomFR as 'Classe 1', C2.NomFR as 'Classe 2', C3.NomFR as 'Classe 3', C4.NomFR as 'Classe 4', Note, E.ImagePath1, E.ImagePath2, E.ImagePath3, E.ImagePath4
									FROM Enregistrements E
									JOIN Utilisateurs U ON E.UtilisateurId = U.Id
									JOIN Teams T ON E.TeamId = T.Id
									JOIN Classes C1 ON T.ClasseId1 = C1.Id
									JOIN Classes C2 ON T.ClasseId2 = C2.Id
									JOIN Classes C3 ON T.ClasseId3 = C3.Id
									JOIN Classes C4 ON T.ClasseId4 = C4.Id
									JOIN BossZones BZ ON E.BossZoneId = BZ.Id
									JOIN Boss B ON BZ.BossId = B.Id
									JOIN Zones Z ON BZ.ZoneId = Z.Id
GO
CREATE VIEW V_Enregistrements_EN AS SELECT U.Id as 'UtilisateurId', BZ.Id as 'BossZoneId', B.NomEN, Z.ContinentEN, Z.ZoneEN, C1.Id as 'IdClasse 1', C2.Id as 'IdClasse 2',C3.Id as 'IdClasse 3',C4.Id as 'IdClasse 4', C1.NomEN as 'Classe 1', C2.NomEN as 'Classe 2', C3.NomEN as 'Classe 3', C4.NomEN as 'Classe 4', Note, E.ImagePath1, E.ImagePath2, E.ImagePath3, E.ImagePath4
									FROM Enregistrements E
									JOIN Utilisateurs U ON E.UtilisateurId = U.Id
									JOIN Teams T ON E.TeamId = T.Id
									JOIN Classes C1 ON T.ClasseId1 = C1.Id
									JOIN Classes C2 ON T.ClasseId2 = C2.Id
									JOIN Classes C3 ON T.ClasseId3 = C3.Id
									JOIN Classes C4 ON T.ClasseId4 = C4.Id
									JOIN BossZones BZ ON E.BossZoneId = BZ.Id
									JOIN Boss B ON BZ.BossId = B.Id
									JOIN Zones Z ON BZ.ZoneId = Z.Id
GO

-------------------------------
-- VUE DU CONTENU DES TABLES --
-------------------------------

USE Ulala

SELECT * FROM Boss
SELECT * FROM Zones
SELECT * FROM BossZones
SELECT * FROM Classes
SELECT * FROM Teams
SELECT * FROM Skills
SELECT * FROM Jouets
SELECT * FROM Utilisateurs
SELECT * FROM Enregistrements
SELECT * FROM Favoris
SELECT * FROM MesTeams
SELECT * FROM Votes
SELECT * FROM V_Enregistrements_FR
SELECT * FROM V_Enregistrements_EN

-------------------------
-- PROCEDURES STOCKEES --
-------------------------

--Ajout utilisateur
CREATE PROCEDURE SP_AjoutUtilisateur
	@Pseudo VARCHAR(20),
	@Mail VARCHAR(100),
	@Password NVARCHAR(64)
AS INSERT INTO Utilisateurs (Pseudo, Mail, Password, Role) VALUES (@Pseudo, @Mail, dbo.SF_HashPassword(@Password), 'User')

--Modif utilisateur
CREATE PROCEDURE SP_ModifUtilisateur
	@Id int,
	@Pseudo VARCHAR(20),
	@Mail VARCHAR(100),
	@Password NVARCHAR(64),
	@Role VARCHAR(20)
AS UPDATE Utilisateurs SET Pseudo = @Pseudo, Mail = @Mail,Password = dbo.SF_HashPassword(@Password), Role = @Role WHERE Id = @Id

--Verification existante Pseudo et match du mot de passe
CREATE PROCEDURE SP_VerifUtilisateur
	@Pseudo NVARCHAR(50),
	@Password NVARCHAR(64),
	@isOk bit OUTPUT
AS SET @isOk = 0; IF EXISTS(SELECT Pseudo FROM Utilisateurs WHERE Pseudo = @Pseudo AND Password = dbo.SF_HashPassword(@Password)) SET @isOk = 1
   
--Ajout Boss
CREATE PROCEDURE SP_AjoutBoss
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50)
AS INSERT INTO Boss (NomFR, NomEN) VALUES (@NomFR,@NomEN)

--Modification Boss
CREATE PROCEDURE SP_ModifBoss
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@Id INT
AS UPDATE Boss SET NomFR = @NomFR, NomEN = @NomEN WHERE Id = @Id

--Ajout Zone
CREATE PROCEDURE SP_AjoutZone
	@ContinentFR VARCHAR(50),
	@ContinentEN VARCHAR(50),
	@ZoneFR VARCHAR(50),
	@ZoneEN VARCHAR(50),
	@NbZones int
AS INSERT INTO Zones (ContinentFR, ContinentEN, ZoneFR, ZoneEN, NbZones) VALUES (@ContinentFR, @ContinentEN, @ZoneFR, @ZoneEN, @NbZones)

--Modification Zone
CREATE PROCEDURE SP_ModifZone
	@ContinentFR VARCHAR(50),
	@ContinentEN VARCHAR(50),
	@ZoneFR VARCHAR(50),
	@ZoneEN VARCHAR(50),
	@NbZones int,
	@Id INT
AS UPDATE Zones SET ContinentFR = @ContinentFR, ContinentEN = @ContinentEN, ZoneFR = @ZoneFR, ZoneEN = @ZoneEN, NbZones = @NbZones WHERE Id = @Id

--Ajout BossZone
CREATE PROCEDURE SP_AjoutBossZone
	@BossId int,
	@ZoneId int
AS INSERT INTO BossZones (BossId, ZoneId) VALUES (@BossId, @ZoneId)

--Modification BossZone
CREATE PROCEDURE SP_ModifBossZone
	@BossId int,
	@ZoneId int,
	@Id INT
AS UPDATE BossZones SET BossId = @BossId, ZoneId = @ZoneId WHERE Id = @Id

--Ajout Classe
CREATE PROCEDURE SP_AjoutClasse
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50)
AS INSERT INTO Classes (NomFR, NomEN) VALUES (@NomFR,@NomEN)

--Modification Classe
CREATE PROCEDURE SP_ModifClasse
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@Id INT
AS UPDATE Classes SET NomFR = @NomFR, NomEN = @NomEN WHERE Id = @Id

--Ajout Skill
CREATE PROCEDURE SP_AjoutSkill
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@ClasseId INT,
	@ImagePath VARCHAR(MAX)
AS INSERT INTO Skills (NomFR, NomEN, ClasseId, ImagePath) VALUES (@NomFR,@NomEN, @ClasseId, @ImagePath)

--Modification Skill
CREATE PROCEDURE SP_ModifSkill
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@ClasseId INT,
	@ImagePath VARCHAR(MAX),
	@Id INT
AS UPDATE Skills SET NomFR = @NomFR, NomEN = @NomEN, ClasseId = @ClasseId, ImagePath = @ImagePath WHERE Id = @Id

--Ajout Enregistrement
CREATE PROCEDURE SP_AjoutEnregistrement
	@UtilisateurId int,
	@BossZoneId int,
	@TeamId int,
	@ImagePath1 VARCHAR(MAX),
	@ImagePath2 VARCHAR(MAX),
	@ImagePath3 VARCHAR(MAX),
	@ImagePath4 VARCHAR(MAX)
AS INSERT INTO Enregistrements (UtilisateurId, BossZoneId, TeamId, ImagePath1, ImagePath2, ImagePath3, ImagePath4, Note) 
						VALUES (@UtilisateurId, @BossZoneId, @TeamId, @ImagePath1, @ImagePath2, @ImagePath3, @ImagePath4, 0)

--Modification Enregistrement
CREATE PROCEDURE SP_ModifEnregistrement
	@UtilisateurId INT,
	@BossZoneId INT,
	@TeamId INT,
	@ImagePath1 VARCHAR(MAX),
	@ImagePath2 VARCHAR(MAX),
	@ImagePath3 VARCHAR(MAX),
	@ImagePath4 VARCHAR(MAX),
	@Note INT,
	@Id INT
AS UPDATE Enregistrements SET UtilisateurId = @UtilisateurId, BossZoneId = @BossZoneId, TeamId = @TeamId, ImagePath1 = @ImagePath1,
						 ImagePath2 = @ImagePath2,ImagePath3 = ImagePath3, ImagePath4 = @ImagePath4, Note = @Note WHERE Id = @Id

--Ajout Favori
CREATE PROCEDURE SP_AjoutFavori
	@UtilisateurId INT,
	@EnregistrementId INT
AS INSERT INTO Favoris (UtilisateurId, EnregistrementId) VALUES (@UtilisateurId,@EnregistrementId)

--Modification Favori
CREATE PROCEDURE SP_ModifFavori
	@UtilisateurId VARCHAR(50),
	@EnregistrementId VARCHAR(50),
	@Id INT
AS UPDATE Favoris SET UtilisateurId = @UtilisateurId, EnregistrementId = @EnregistrementId WHERE Id = @Id

--Ajout MesTeams
CREATE PROCEDURE SP_AjoutMaTeam
	@UtilisateurId INT,
	@TeamId INT,
	@ZoneId INT,
	@NomTeam VARCHAR(25)
AS INSERT INTO MesTeams (UtilisateurId, TeamId, ZoneId, NomTeam) VALUES (@UtilisateurId, @TeamId, @ZoneId, @NomTeam)

--Modification MesTeams
CREATE PROCEDURE SP_ModifMaTeam
	@UtilisateurId INT,
	@TeamId INT,
	@NomTeam VARCHAR(25),
	@ZoneId INT,
	@Id INT
AS UPDATE MesTeams SET UtilisateurId = @UtilisateurId, TeamId = @TeamId, ZoneId = @ZoneId, NomTeam = @NomTeam WHERE Id = @Id
						
--Ajout Jouets
CREATE PROCEDURE SP_AjoutJouet
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@ImagePath VARCHAR(MAX)
AS INSERT INTO Jouets (NomFR, NomEN, ImagePath) VALUES (@NomFR,@NomEN, @ImagePath)

--Modification Jouets
CREATE PROCEDURE SP_ModifJouet
	@NomFR VARCHAR(50),
	@NomEN VARCHAR(50),
	@ImagePath VARCHAR(MAX),
	@Id INT
AS UPDATE Jouets SET NomFR = @NomFR, NomEN = @NomEN, ImagePath = @ImagePath WHERE Id = @Id

--Ajout Votes
CREATE PROCEDURE SP_AjoutVote
	@EnregistrementId INT,
	@UtilisateurId INT,
	@Vote INT
AS INSERT INTO Votes (EnregistrementId, UtilisateurId, Vote) VALUES (@EnregistrementId, @UtilisateurId, @Vote)

--Modification Votes
CREATE PROCEDURE SP_ModifVote
	@EnregistrementId INT,
	@UtilisateurId INT,
	@Vote INT,
	@Id INT
AS UPDATE Votes SET EnregistrementId = @EnregistrementId, UtilisateurId = @UtilisateurId, Vote = @Vote WHERE Id = @Id;

--Ajout Team
CREATE PROCEDURE SP_AjoutTeam
	@ClasseId1 INT,
	@ClasseId2 INT,
	@ClasseId3 INT,
	@ClasseId4 INT
AS INSERT INTO Teams (ClasseId1, ClasseId2, ClasseId3, ClasseId4) VALUES (@ClasseId1, @ClasseId2, @ClasseId3, @ClasseId4)

--Modification Team
CREATE PROCEDURE SP_ModifTeam
	@ClasseId1 INT,
	@ClasseId2 INT,
	@ClasseId3 INT,
	@ClasseId4 INT,
	@Id INT
AS UPDATE Teams SET ClasseId1 = @ClasseId1, ClasseId2 = @ClasseId2, ClasseId3 = @ClasseId3, ClasseId4 = @ClasseId4 WHERE Id = @Id;

---------------
-- FONCTIONS --
---------------

CREATE FUNCTION SF_HashPassword
(
	@Password varchar(64)
)
RETURNS VARBINARY(32)
AS
	BEGIN
		DECLARE @PasswordWithNoise NVARCHAR(MAX)
		SET @PasswordWithNoise = 'TdPeDQdfFsCdEf'+ @Password +'dFgGgFrfXfEgzMhj'
		RETURN HASHBYTES('SHA2_256',@PasswordWithNoise)
	END


-------------
-- TRIGGER --
-------------

-- "ON DELETE" NE supprime pas mais passe la colonne Actif � 0

CREATE TRIGGER TR_DeleteUtilisateur
    ON Utilisateurs
    INSTEAD OF DELETE
AS UPDATE Utilisateurs SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteBoss
    ON Boss
    INSTEAD OF DELETE
AS UPDATE Boss SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteZone
    ON Zones
    INSTEAD OF DELETE
AS UPDATE Zones SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteBossZone
    ON BossZones 
    INSTEAD OF DELETE
AS UPDATE BossZones SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteClasse
    ON Classes
    INSTEAD OF DELETE
AS UPDATE Classes SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteSkill
    ON Skills
    INSTEAD OF DELETE
AS UPDATE Skills SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteEnregistrement
    ON Enregistrements
    INSTEAD OF DELETE
AS UPDATE Enregistrements SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteFavori
    ON Favoris
    INSTEAD OF DELETE
AS UPDATE Favoris SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteMesTeam
    ON MesTeams
    INSTEAD OF DELETE
AS UPDATE MesTeams SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteJouet
    ON Jouets
    INSTEAD OF DELETE
AS UPDATE Jouets SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteVote
    ON Votes
    INSTEAD OF DELETE
AS UPDATE Votes SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)

CREATE TRIGGER TR_DeleteTeam
    ON Teams
    INSTEAD OF DELETE
AS UPDATE Teams SET Actif = '0' WHERE Id = (SELECT Id FROM deleted)
