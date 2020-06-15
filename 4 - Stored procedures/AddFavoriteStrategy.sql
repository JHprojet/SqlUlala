CREATE PROCEDURE SP_AddFavoriteStrategy
	@UserId INT,
	@StrategyId INT
AS INSERT INTO FavoriteStrategies (UserId, StrategyId) VALUES (@UserId,@StrategyId)