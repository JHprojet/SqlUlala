CREATE PROCEDURE SP_ChangePassword
	@Id INT,
	@NewPassword NVARCHAR(MAX),
	@IsOk bit OUTPUT
AS 
  IF EXISTS(SELECT Id FROM Users WHERE Id = @Id) 
	BEGIN
	SET @IsOk = 1;
	UPDATE Users SET Password  = dbo.SF_HashPassword(@NewPassword) WHERE Id = @Id
	END
  ELSE
	BEGIN
	SET @isOk = 0
	END
