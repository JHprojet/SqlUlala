CREATE TRIGGER TR_DeleteSkill
    ON Skills
    INSTEAD OF DELETE
AS UPDATE Skills SET Active = '0' WHERE Id = (SELECT Id FROM deleted)