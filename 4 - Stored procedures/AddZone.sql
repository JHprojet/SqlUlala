CREATE PROCEDURE SP_AddZone
	@ContinentFR VARCHAR(50),
	@ContinentEN VARCHAR(50),
	@ZoneFR VARCHAR(50),
	@ZoneEN VARCHAR(50),
	@ZoneQty int
AS INSERT INTO Zones (ContinentFR, ContinentEN, ZoneFR, ZoneEN, ZoneQty) VALUES (@ContinentFR, @ContinentEN, @ZoneFR, @ZoneEN, @ZoneQty)