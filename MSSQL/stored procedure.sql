**AUTHOR	: MANOJ K
** DATE 	: 28-06-2024
** PRO.NAME	: WRITE A STORED PROCEDURE  TO FIND THE MOST PURCHASED PRODUCT OF EACH CUSTOMER;
 
** QUERY	:
					CREATE PROCEDURE CUSTOMER_PURCHASE @CUSTOMERID INT
					AS
					BEGIN
						 WITH A AS (SELECT CUSTOMERID,
										   D.PRODUCTID ,
										   SUM(ORDERQTY )AS MAX_PURCHASED_QTY, 
										   RANK() OVER (PARTITION BY CUSTOMERID ORDER BY (SUM(ORDERQTY)) DESC ) AS TOP_PRODUCT
									 
									 FROM SALES.SALESORDERHEADER H 
										INNER JOIN SALES.SALESORDERDETAIL D ON H.SALESORDERID = D.SALESORDERID --WHERE CUSTOMERID =  
											GROUP BY CUSTOMERID,D.PRODUCTID)

						SELECT CUSTOMERID,
							   A.PRODUCTID,
							   NAME,
							   A.MAX_PURCHASED_QTY
								FROM A
									INNER JOIN PRODUCTION.PRODUCT P ON A.PRODUCTID = P.PRODUCTID 
										WHERE CUSTOMERID = @CUSTOMERID  AND TOP_PRODUCT = 1
											ORDER BY CUSTOMERID
						END;

					  
EXEC  CUSTOMER_PURCHASE @CUSTOMERID = 16616;


