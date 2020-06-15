CREATE PROCEDURE SP_SendActivationToken
	@Id INT
AS
	DECLARE @mail VARCHAR(MAX)
	DECLARE @token VARCHAR(MAX)
	SET @mail = (SELECT Mail from Users WHERE Id = @Id)
	SET @token = (SELECT ActivationToken from Users WHERE Id = @Id)

EXEC msdb.dbo.sp_send_dbmail @profile_name ='Ulala Admin Profile',
@recipients = @mail,
@subject ='Activation Link',
@body = @token
--TODO : Add text in the mail