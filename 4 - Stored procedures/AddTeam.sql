CREATE PROCEDURE SP_AddTeam
	@UserId INT,
	@CharactersConfigurationId INT,
	@ZoneId INT,
	@TeamName VARCHAR(25)
AS INSERT INTO Teams (UserId, CharactersConfigurationId, ZoneId, TeamName) VALUES (@UserId, @CharactersConfigurationId, @ZoneId, @TeamName)
