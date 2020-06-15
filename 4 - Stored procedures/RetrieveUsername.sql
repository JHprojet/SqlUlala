-- send Username by mail
CREATE PROCEDURE SP_RetrieveUsername
	@Mail VARCHAR(MAX),
	@IsOk bit OUTPUT
AS
DECLARE @base VARCHAR(180) = 'Following your demand, here is your username for UlalaStrat website : ',
	@Username VARCHAR (50) = (SELECT Username FROM Users WHERE Mail = @Mail),
	@tot VARCHAR(MAX) = ''
	SET @tot = @base + @Username
	IF EXISTS(SELECT Mail FROM Users WHERE Mail = @Mail) 
	BEGIN
	
		SET @tot = @base + @Username;
		EXEC msdb.dbo.sp_send_dbmail @profile_name ='Ulala Admin Profile',
		@recipients = @Mail,
		@subject ='Your username on Ulala-strat',
		@body = @tot
		SET @IsOk = 1
	END
	ELSE SET @IsOk = 0;