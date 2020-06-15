CREATE PROCEDURE SP_UpdateClasse
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@Id INT
AS UPDATE Classes SET NameFR = @NameFR, NameEN = @NameEN WHERE Id = @Id