CREATE PROCEDURE SP_UpdateVote
	@StrategyId INT,
	@UserId INT,
	@Vote INT,
	@Id INT
AS UPDATE Votes SET StrategyId = @StrategyId, UserId = @UserId, Vote = @Vote WHERE Id = @Id;