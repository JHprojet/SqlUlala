CREATE TRIGGER TR_DeleteZone
    ON Zones
    INSTEAD OF DELETE
AS UPDATE Zones SET Active = '0' WHERE Id = (SELECT Id FROM deleted)