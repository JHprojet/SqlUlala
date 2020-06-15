CREATE PROCEDURE SP_UpdateFavoriteStrategy
	@UserId VARCHAR(50),
	@StrategyId VARCHAR(50),
	@Id INT
AS UPDATE FavoriteStrategies SET UserId = @UserId, StrategyId = @StrategyId WHERE Id = @Id