CREATE PROCEDURE SP_AddToy
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@ImagePath VARCHAR(MAX)
AS INSERT INTO Toys (NameFR, NameEN, ImagePath) VALUES (@NameFR,@NameEN, @ImagePath)