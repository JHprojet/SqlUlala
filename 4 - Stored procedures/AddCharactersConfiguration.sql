CREATE PROCEDURE SP_AddCharactersConfiguration
	@ClasseId1 INT,
	@ClasseId2 INT,
	@ClasseId3 INT,
	@ClasseId4 INT
AS INSERT INTO CharactersConfigurations (ClasseId1, ClasseId2, ClasseId3, ClasseId4) 
    VALUES (@ClasseId1, @ClasseId2, @ClasseId3, @ClasseId4)