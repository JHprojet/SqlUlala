CREATE PROCEDURE SP_UpdateStrategy
	@UserId INT,
	@BossZoneId INT,
	@CharactersConfigurationId INT,
	@ImagePath1 VARCHAR(MAX),
	@ImagePath2 VARCHAR(MAX),
	@ImagePath3 VARCHAR(MAX),
	@ImagePath4 VARCHAR(MAX),
	@Note INT,
	@Id INT
AS UPDATE Strategies SET UserId = @UserId, BossZoneId = @BossZoneId, CharactersConfigurationId = @CharactersConfigurationId, ImagePath1 = @ImagePath1,
						 ImagePath2 = @ImagePath2,ImagePath3 = ImagePath3, ImagePath4 = @ImagePath4, Note = @Note WHERE Id = @Id
