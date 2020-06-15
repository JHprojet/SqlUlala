CREATE TRIGGER TR_DeleteCharactersConfiguration
    ON Teams
    INSTEAD OF DELETE
AS UPDATE CharactersConfigurations SET Active = '0' WHERE Id = (SELECT Id FROM deleted)