CREATE TRIGGER TR_DeleteToy
    ON Toys
    INSTEAD OF DELETE
AS UPDATE Toys SET Active = '0' WHERE Id = (SELECT Id FROM deleted)