CREATE TRIGGER TR_DeleteBoss
    ON Bosses
    INSTEAD OF DELETE
AS UPDATE Bosses SET Active = '0' WHERE Id = (SELECT Id FROM deleted)