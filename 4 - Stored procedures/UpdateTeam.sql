CREATE PROCEDURE SP_UpdateTeam
	@UserId INT,
	@CharactersConfigurationId INT,
	@TeamName VARCHAR(25),
	@ZoneId INT,
	@Id INT
AS UPDATE Teams SET UserId = @UserId, CharactersConfigurationId = @CharactersConfigurationId, ZoneId = @ZoneId, TeamName = @TeamName WHERE Id = @Id
