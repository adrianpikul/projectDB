-- Add new row in ProjFinance

DROP PROCEDURE IF EXISTS mydb.addprojFinanceOne ;
DELIMITER //
CREATE PROCEDURE mydb.addprojFinanceOne 
(
  IN IBudget FLOAT, 
  IN IExpectedProfit FLOAT, 
  IN IBonusManager FLOAT, 
  IN IPenaltyPerDay FLOAT,
  IN ICosts FLOAT,
  IN IAdditionalCosts FLOAT
)
BEGIN
  INSERT INTO mydb.ProjFinance(Budget, ExpectedProfit, BonusManager, PenaltyPerDay, Costs,  AdditionalCosts) 
  VALUES (IBudget, IExpectedProfit, IBonusManager, IPenaltyPerDay, ICosts,  IAdditionalCosts);
END //
DELIMITER ;

CALL mydb.addprojFinanceOne (187554.2,454332.3,5642.3,1.2,56254, 1643.4);
-------------
-------------
-------------
-- Show all daily raports for id project between date

DROP PROCEDURE IF EXISTS mydb.getAllDRForProjBetweenDate ;
DELIMITER //
CREATE PROCEDURE getAllDRForProjBetweenDate
(
	IN STARTDATE VARCHAR(10),
    IN ENDDATE VARCHAR(10),
    IN IDPROJECT INT
)

BEGIN 
	SELECT * FROM mydb.DailyRaport
	WHERE Date BETWEEN STR_TO_DATE(STARTDATE,'%d,%m,%Y') 
	AND STR_TO_DATE(ENDDATE,'%d,%m,%Y')
	AND DailyRaport.idProjects= IDPROJECT
	ORDER BY Date;
END //
DELIMITER ;

CALL mydb.getAllDRForProjBetweenDate ('2,1,2015', '18,1,2022', 6);
-------------
-------------
-------------
-- Show all daily raports for workers between date

DROP PROCEDURE IF EXISTS mydb.getAllDRForWorkBetweenDate ;
DELIMITER //
CREATE PROCEDURE getAllDRForWorkBetweenDate
(
	IN STARTDATE VARCHAR(10),
    IN ENDDATE VARCHAR(10),
    IN IDWORKER INT
)
BEGIN
	SELECT * FROM DailyRaport 
	WHERE Date BETWEEN STR_TO_DATE(STARTDATE,'%d,%m,%Y') 
	AND STR_TO_DATE(ENDDATE,'%d,%m,%Y')
	AND idWorkers = IDWORKER;
END //
DELIMITER ;

CALL mydb.getAllDRForWorkBetweenDate ('2,1,2015', '18,1,2022', 13);
-------------
-------------
-------------
-- Update projFinance from ID
DROP PROCEDURE IF EXISTS mydb.updateProjFinanceFromId ;
DELIMITER //
CREATE PROCEDURE updateProjFinanceFromId
(
	IN BudgetN FLOAT,
    IN ExpcetedProfitN FLOAT,
    IN BonusManagerN FLOAT,
    IN PenaltyPerDayN FLOAT,
    IN CostsN FLOAT,
    IN AdditionalCostsN FLOAT,
    IN idProjFin INT
)
BEGIN
	UPDATE ProjFinance
	SET Budget = BudgetN, ExpectedProfit = ExpcetedProfitN, BonusManager = BonusManagerN, PenaltyPerDay = PenaltyPerDayN, Costs = CostsN, AdditionalCosts = AdditionalCostsN
	WHERE idProjFinance = idProjFin;
    
END //
DELIMITER ;

SELECT * FROM ProjFinance where idProjFinance = 85;
CALL mydb.updateProjFinanceFromId(187554.2,454332.3,5642.3,1.2,56254, 1643.4, 85);
SELECT * FROM ProjFinance where idProjFinance = 85;
-------------
-------------
-------------
-- Add new Contracts to workersID
DROP PROCEDURE IF EXISTS mydb.addConcractToIdWorker ;
DELIMITER //
CREATE PROCEDURE mydb.addConcractToIdWorker 
(
  IN DateStartN VARCHAR(10), 
  IN DateENDN VARCHAR(10), 
  IN PositionN VARCHAR(45), 
  IN RateDayN FLOAT,
  IN idWorkersN INT
)
BEGIN
  INSERT INTO mydb.Contracts(DateStart, DateEND, Position, RateDay, idWorkers) 
  VALUES (STR_TO_DATE(DateStartN,'%d,%m,%Y') , STR_TO_DATE(DateENDN,'%d,%m,%Y')  , PositionN, RateDayN, idWorkersN);
END //
DELIMITER ;

SELECT * FROM mydb.Contracts WHERE idWorkers = 90 ORDER BY DateStart DESC;
CALL mydb.addConcractToIdWorker ('2,10,2023', '25,1,2024', 'Database specialist', 450.23, 90);
SELECT * FROM mydb.Contracts WHERE idWorkers = 90 ORDER BY DateStart DESC;
-------------
-------------
-------------
-- Remove workers contracts from id workers, date start and date end
DROP PROCEDURE IF EXISTS mydb.deleteContractidWorkersDateStartEnd ;
DELIMITER //
CREATE PROCEDURE mydb.deleteContractidWorkersDateStartEnd 
(
  IN DateStartN VARCHAR(10), 
  IN DateENDN VARCHAR(10), 
  IN idWorkersN INT
)
BEGIN
	DELETE FROM mydb.Contracts WHERE idWorkers = idWorkersN AND DateStart = STR_TO_DATE(DateStartN,'%d,%m,%Y') AND DateEND  = STR_TO_DATE(DateENDN,'%d,%m,%Y');
END //
DELIMITER ;
SELECT * FROM mydb.Contracts WHERE idWorkers = 90 ORDER BY DateStart DESC;
CALL mydb.deleteContractidWorkersDateStartEnd ('2,10,2023', '25,1,2024', 90);
SELECT * FROM mydb.Contracts WHERE idWorkers = 90 ORDER BY DateStart DESC;
-------------
-------------
-------------
-- Show all workers rent for project
DROP PROCEDURE IF EXISTS mydb.sumWorkersRentForProject ;
DELIMITER //
CREATE PROCEDURE sumWorkersRentForProject
(
    IN InputIdProject INT
)
BEGIN
	DECLARE spDate VARCHAR(10);
	DECLARE epDate VARCHAR(10);
    SET @spDate = (SELECT DateStart FROM Projects WHERE idProjects = InputIdProject);
    SET @epDate = (SELECT DateEnd FROM Projects WHERE idProjects = InputIdProject);
    
	SELECT ROUND(SUM(dd.RateDay), 2) FROM (
		SELECT DISTINCT dp.Date, dp.idWorkers, c.RateDay 
        FROM DailyRaport dp
		JOIN mydb.Contracts c ON c.idWorkers = dp.idWorkers 
		WHERE Date BETWEEN STR_TO_DATE(@spDate,'%Y-%m-%d') 
		AND STR_TO_DATE(@epDate,'%Y-%m-%d')
		ORDER BY dp.Date) 
	AS dd;
END //
DELIMITER ;

CALL mydb.sumWorkersRentForProject (17);

