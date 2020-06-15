-- Create and send activation Token by mail
CREATE TRIGGER TR_SendActivationToken
    ON Users
    AFTER INSERT
AS
    DECLARE @minLength INT = 8,
    @maxLength INT = 12,
    @chars VARCHAR(200) = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
    @randomString VARCHAR(MAX) = NULL,
    @base VARCHAR(50) = 'Voici votre lien d''activation : ',
    @mail VARCHAR(200) = (SELECT Mail from inserted)
BEGIN
    DECLARE @stringLength INT = dbo.FN_RandIntBetween(@minLength, @maxLength, RAND());
    SET @randomString = '';
    WHILE LEN(@randomString) < @stringLength
    BEGIN
        SET @randomString = @randomString + dbo.FN_PickRandomChar(@chars, RAND());
    END
    UPDATE Users SET ActivationToken = @randomString WHERE Id = (SELECT Id FROM inserted)

    EXEC msdb.dbo.sp_send_dbmail @profile_name ='Ulala Admin Profile',
    @recipients = @mail,
    @subject ='Activation Token',
    @body = @randomString
END