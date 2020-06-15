CREATE PROCEDURE SP_AddOneUser
	@Username VARCHAR(20),
	@Mail VARCHAR(100),
	@Password NVARCHAR(64)
AS INSERT INTO Users (Username, Mail, Password, Role) VALUES (@Username, @Mail, dbo.SF_HashPassword(@Password), 'User')