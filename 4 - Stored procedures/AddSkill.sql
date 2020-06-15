CREATE PROCEDURE SP_AddSkill
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@DescriptionFR VARCHAR(MAX),
	@DescriptionEN VARCHAR(MAX),
	@Location VARCHAR(MAX),
	@Cost INT,
	@ClasseId INT,
	@ImagePath VARCHAR(MAX)
AS INSERT INTO Skills (NameFR, NameEN, DescriptionFR, DescriptionEN, Cost, Location, ClasseId, ImagePath) 
            VALUES (@NameFR,@NameEN, @DescriptionFR, @DescriptionEN, @Cost, @Location, @ClasseId, @ImagePath)
