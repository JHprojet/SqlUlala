CREATE PROCEDURE SP_UpdateZone
	@ContinentFR VARCHAR(50),
	@ContinentEN VARCHAR(50),
	@ZoneFR VARCHAR(50),
	@ZoneEN VARCHAR(50),
	@ZoneQty int,
	@Id INT
AS UPDATE Zones SET ContinentFR = @ContinentFR, ContinentEN = @ContinentEN, ZoneFR = @ZoneFR, ZoneEN = @ZoneEN, ZoneQty = @ZoneQty WHERE Id = @Id