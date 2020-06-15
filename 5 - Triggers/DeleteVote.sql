CREATE TRIGGER TR_DeleteVote
    ON Votes
    AFTER DELETE
AS 
    UPDATE Strategies
    SET Note -= (SELECT Note FROM deleted) 
    WHERE Id = (SELECT StrategyId FROM deleted)
