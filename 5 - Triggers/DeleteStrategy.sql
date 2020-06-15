CREATE TRIGGER TR_DeleteStrategy
    ON Strategies
    INSTEAD OF DELETE
AS UPDATE Strategies SET Active = '0' WHERE Id = (SELECT Id FROM deleted)