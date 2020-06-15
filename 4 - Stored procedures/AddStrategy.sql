CREATE PROCEDURE SP_AddStrategy
	@UserId int,
	@BossZoneId int,
	@CharactersConfigurationId int,
	@ImagePath1 VARCHAR(MAX),
	@ImagePath2 VARCHAR(MAX),
	@ImagePath3 VARCHAR(MAX),
	@ImagePath4 VARCHAR(MAX)
AS INSERT INTO Strategies (UserId, BossZoneId, CharactersConfigurationId, ImagePath1, ImagePath2, ImagePath3, ImagePath4, Note) 
						VALUES (@UserId, @BossZoneId, @CharactersConfigurationId, @ImagePath1, @ImagePath2, @ImagePath3, @ImagePath4, 0)