CREATE PROCEDURE SP_AddVote
	@StrategyId INT,
	@UserId INT,
	@Vote INT
AS INSERT INTO Votes (StrategyId, UserId, Vote) VALUES (@StrategyId, @UserId, @Vote)