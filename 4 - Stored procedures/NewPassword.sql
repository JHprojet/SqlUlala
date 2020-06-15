-- Send a new password by mail
CREATE PROCEDURE SP_NewPassword
	@Mail VARCHAR(MAX),
	@IsOk bit OUTPUT
AS
DECLARE @minLength INT = 10,
    @maxLength INT = 12,
    @base VARCHAR(180) = 'Following your demand, here is your new password. You can log in with this new password and change your password in your profil page : ',
    @chars VARCHAR(200) = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
    @randomString VARCHAR(20) = '',
	@tot VARCHAR(MAX) =''
	IF EXISTS(SELECT Mail FROM Users WHERE Mail = @Mail) 
	BEGIN
		DECLARE @stringLength INT = dbo.FN_RandIntBetween(@minLength, @maxLength, RAND());
    		SET @randomString = '';
    		WHILE LEN(@randomString) < @stringLength
    		BEGIN
        		SET @randomString = @randomString + dbo.FN_PickRandomChar(@chars, RAND());
    		END
		UPDATE Users SET Password = dbo.SF_HashPassword(@randomString) WHERE Mail = (SELECT Mail FROM Users WHERE Mail = @Mail)
		SET @tot = @base + @randomString;
		EXEC msdb.dbo.sp_send_dbmail @profile_name ='UlalaStrat Admin Profile',
		@recipients = @Mail,
		@subject ='Your new password',
		@body = @tot
		SET @IsOk = 1
	END
	ELSE SET @IsOk = 0;