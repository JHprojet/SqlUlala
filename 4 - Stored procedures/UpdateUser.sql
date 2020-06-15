CREATE PROCEDURE SP_UpdateUser
	@Id int,
	@Username VARCHAR(20),
	@Mail VARCHAR(100),
	@Role VARCHAR(20),
	@Active INT
AS UPDATE Users SET Username = @Username, Mail = @Mail, Role = @Role, Active = @Active WHERE Id = @Id