CREATE PROCEDURE SP_UpdateToy
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@ImagePath VARCHAR(MAX),
	@Id INT
AS UPDATE Toys SET NameFR = @NameFR, NameEN = @NameEN, ImagePath = @ImagePath WHERE Id = @Id