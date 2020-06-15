CREATE PROCEDURE SP_UpdateCharactersConfiguration
	@ClasseId1 INT,
	@ClasseId2 INT,
	@ClasseId3 INT,
	@ClasseId4 INT,
	@Id INT
AS UPDATE CharactersConfigurations SET ClasseId1 = @ClasseId1, ClasseId2 = @ClasseId2, ClasseId3 = @ClasseId3, ClasseId4 = @ClasseId4 
                                    WHERE Id = @Id;