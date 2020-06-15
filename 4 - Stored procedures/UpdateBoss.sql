CREATE PROCEDURE SP_UpdateBoss
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@Id INT
AS UPDATE Bosses SET NameFR = @NameFR, NameEN = @NameEN WHERE Id = @Id