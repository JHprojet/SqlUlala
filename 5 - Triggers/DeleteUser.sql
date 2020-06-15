CREATE TRIGGER TR_DeleteUser
    ON Users
    INSTEAD OF DELETE
AS UPDATE Users SET Active = '0' WHERE Id = (SELECT Id FROM deleted)