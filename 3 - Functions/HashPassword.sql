--Fonction de Hash de password
CREATE FUNCTION SF_HashPassword
(
	@Password varchar(64)
)
RETURNS VARBINARY(32)
AS
BEGIN
    DECLARE @PasswordWithNoise NVARCHAR(MAX)
    SET @PasswordWithNoise = 'TdPeDQdfFsCdEf'+ @Password +'dFgGgFrfXfEgzMhj'
    RETURN HASHBYTES('SHA2_256',@PasswordWithNoise)
END

