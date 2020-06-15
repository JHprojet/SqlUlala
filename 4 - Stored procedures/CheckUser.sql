CREATE PROCEDURE SP_CheckUser
	@Username NVARCHAR(50),
	@Password NVARCHAR(64),
	@isOk bit OUTPUT
AS SET @isOk = 0; IF EXISTS(SELECT Username FROM Users WHERE Username = @Username AND Password = dbo.SF_HashPassword(@Password)) SET @isOk = 1