CREATE PROCEDURE SP_UpdateSkill
	@NameFR VARCHAR(50),
	@NameEN VARCHAR(50),
	@DescriptionFR VARCHAR(MAX),
	@DescriptionEN VARCHAR(MAX),
	@Location VARCHAR(MAX),
	@Cost INT,
	@ClasseId INT,
	@ImagePath VARCHAR(MAX),
	@Id INT
AS UPDATE Skills SET NameFR = @NameFR, NameEN = @NameEN, DescriptionFR = @DescriptionFR, DescriptionEN = @DescriptionEN, Cost = @Cost, 
                    Location = @Location, ClasseId = @ClasseId, ImagePath = @ImagePath 
                WHERE Id = @Id