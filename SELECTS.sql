-- SELECTS

-- Show name, surname from workers ID
SELECT Name, Surname 
FROM projDB.Workers 
WHERE idWorkers = 2;

-- Show all projects where Area > 1700
SELECT * 
FROM Projects 
WHERE Area > 1700 
ORDER BY Area;

-- Show all contracts for workers id, order by idWorkers next order DateStart
SELECT * 
FROM Contracts 
WHERE idWorkers = 64 
ORDER BY DATESTART;

-- Show daily raport from project id, order by idDailyRaport
SELECT * 
FROM DailyRaport 
WHERE  idProjects = 88 
ORDER BY idDailyRaport ;

-- Show all daily rapots between date
SELECT * 
FROM mydb.DailyRaport
WHERE Date BETWEEN STR_TO_DATE('2,1,2019','%d,%m,%Y') 
AND STR_TO_DATE('18,1,2020','%d,%m,%Y');

-- Show project manager from Project ID
SELECT idWorkers, Name, Surname, Phone, Mail, Pesel
FROM mydb.Workers 
WHERE idWorkers = (SELECT idManager FROM mydb.Projects WHERE  idProjects = 34);

-- Show name project, date start, date end and budget
SELECT Name, DateStart, DateEnd, Budget 
FROM projDB.Projects 
JOIN projDB.ProjFinance ON Projects.idProjects = ProjFinance.idProjFinance;

-- Show detailed data about Customers
SELECT p.Name, c.CompanyName, c.NIP, c.City, c.Street, c.ZipCode 
FROM projDB.Projects p 
JOIN projDB.Customers c ON p.idProjects = c.idCustomers;

-- Show Costumers Projects
SELECT c.Name, c.Surname, c.CompanyName, c.NIP, p.Name
FROM mydb.Customers c 
RIGHT JOIN mydb.Projects p ON p.idCustomers = c.idCustomers;

-- Show workers, project name on daily project -> daily raport
SELECT d.idDailyRaport, p.idProjects, p.Name, w.Surname, w.Name
FROM projDB.DailyRaport d 
JOIN projDB.Projects p ON d.idProjects = p.idProjects 
JOIN projDB.Workers w ON d.idWorkers = w.idWorkers
ORDER BY d.idDailyRaport, w.Surname, w.Name;




