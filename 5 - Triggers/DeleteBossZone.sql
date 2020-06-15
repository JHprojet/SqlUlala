CREATE TRIGGER TR_DeleteBossZone
    ON BossesPerZones 
    INSTEAD OF DELETE
AS UPDATE BossesPerZones SET Active = '0' WHERE Id = (SELECT Id FROM deleted)