CREATE PROCEDURE SP_AddBossZone
	@BossId int,
	@ZoneId int
AS INSERT INTO BossesPerZones (BossId, ZoneId) VALUES (@BossId, @ZoneId)