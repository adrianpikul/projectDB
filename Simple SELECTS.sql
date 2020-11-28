-- SIMPLE SELECTS

SELECT * FROM Projects;

SELECT * FROM DailyRaport;

SELECT * FROM DailyRaport ORDER BY idDailyRaport;

SELECT * FROM Contracts ORDER BY IDWORKERS, DATESTART;

SELECT Name, Surname FROM projDB.Workers WHERE idWorkers = 2;

SELECT idWorkers, COUNT(*) FROM projDB.DailyRaport GROUP BY idProjects;

SELECT Name, Surname, RateDay 
FROM projDB.Workers 
JOIN projDB.Contracts ON  Workers.idWorkers = Contracts.idContracts;

SELECT Name, DateStart, DateEnd, Budget 
FROM projDB.Projects 
JOIN projDB.ProjFinance ON Projects.idProjects = ProjFinance.idProjFinance;

SELECT p.Name, c.CompanyName, c.NIP, c.City 
FROM projDB.Projects p 
JOIN projDB.Customers c ON p.idProjects = c.idCustomers;

SELECT d.idDailyRaport, p.idProjects, p.Name, w.Surname, w.Name
FROM projDB.DailyRaport d 
JOIN projDB.Projects p ON d.idProjects = p.idProjects 
JOIN projDB.Workers w ON d.idWorkers = w.idWorkers
ORDER BY d.idDailyRaport, w.Surname, w.Name;


