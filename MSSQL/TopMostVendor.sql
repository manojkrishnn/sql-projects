** AUTHOR	: MANOJ K
** DATE 	: 28-06-2024
** PRO.NAME	: TO FIND THE TOPMOST VENDOR FOR EACH EMPLOYEE
** QUERY	:

				CREATE OR ALTER PROCEDURE TOPVENDOR @TOPNUMBER INT 
				AS

				 WITH H AS (SELECT  EMPLOYEEID, 
									VENDORID, 
									SUM(TOTALDUE)AS PURCHASEVALUE, 
									DENSE_RANK() OVER (PARTITION BY EMPLOYEEID ORDER BY SUM(TOTALDUE) DESC ) AS MOST_ORDEREDVENDOR 
										FROM PURCHASING.PURCHASEORDERHEADER 
											GROUP BY  EMPLOYEEID, VENDORID)
					
					SELECT  EMPLOYEEID,
							D.NAME  ,
							CAST(PURCHASEVALUE AS DECIMAL (10,1)) AS PURCHASEVALUE, 
							H.VENDORID,
							V.NAME 
							
					
								FROM H 
									INNER JOIN PURCHASING.VENDOR V ON H.VENDORID = V.BUSINESSENTITYID
									INNER JOIN HUMANRESOURCES.EMPLOYEEDEPARTMENTHISTORY E ON H.EMPLOYEEID = E.BUSINESSENTITYID
									INNER JOIN HUMANRESOURCES.DEPARTMENT D ON E.DEPARTMENTID = D.DEPARTMENTID
										WHERE MOST_ORDEREDVENDOR = @TOPNUMBER AND ENDDATE IS NULL;

				EXEC TOPVENDOR @TOPNUMBER = 4
