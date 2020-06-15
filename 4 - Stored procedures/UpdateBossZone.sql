CREATE PROCEDURE SP_UpdateBossZone
	@BossId int,
	@ZoneId int,
	@Id INT
AS UPDATE BossesPerZones SET BossId = @BossId, ZoneId = @ZoneId WHERE Id = @Id