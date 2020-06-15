CREATE TRIGGER TR_DeleteClasse
    ON Classes
    INSTEAD OF DELETE
AS UPDATE Classes SET Active = '0' WHERE Id = (SELECT Id FROM deleted)