** AUTHOR	: MANOJ K
** DATE 	: 20-06-2024
** PRO.NAME	: WRITE A STORED PROCEDURE TO FIND THE NO OF SALESORDER BASED ON QUANTITY OF SALESORDER
** QUERY	:

				CREATE OR ALTER PROCEDURE SALESORDER @ID INT
				AS 
				BEGIN

					WITH A AS (SELECT H.SALESORDERID AS SALESID, COUNT(SALESORDERDETAILID)AS DETAILID_COUNT, 
											SUM(LINETOTAL) AS SALES_TOTAL FROM SALES.SALESORDERHEADER H 
												INNER JOIN SALES.SALESORDERDETAIL D ON H.SALESORDERID = D.SALESORDERID 
												-- WHERE H.SALESORDERID < @ID
														GROUP BY H.SALESORDERID
															HAVING COUNT(SALESORDERDETAILID) <@ID )
					
					SELECT COUNT(1) FROM   A

 
				END;
 
				EXEC SALESORDER @ID = 4;