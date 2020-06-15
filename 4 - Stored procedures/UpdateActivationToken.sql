CREATE PROCEDURE SP_UpdateActivationToken
	@Id INT,
	@ActivationToken NVARCHAR(MAX),
	@isOk bit OUTPUT
AS 
IF ((SELECT ActivationToken FROM Users WHERE Id = @Id) = @ActivationToken)
    BEGIN
    SET @isOK = 1;
    UPDATE Users SET ActivationToken = null WHERE Id = @Id;
    END
ELSE
    BEGIN
    SET @isOK = 0;
    END
