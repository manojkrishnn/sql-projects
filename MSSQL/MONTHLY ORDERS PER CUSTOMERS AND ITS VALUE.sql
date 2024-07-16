** AUTHOR	: MANOJ K
** DATE 	: 18-06-2024
** PRO.NAME	: TO FIND TOTAL NO OF SALESORDER AND ITS TOTAL VALUE BASED ON MONTH-WISE FOR EACH CUSTOMER
** QUERY	:

				
				WITH SALES_ORDERS AS (SELECT H.CustomerID, H.SalesOrderID AS ORDERID,LineTotal,  
											 YEAR(OrderDate) AS YEAR_, 
											 DATENAME (MONTH,ORDERDATE) AS NAME_OF_MONTH, MONTH(OrderDate) AS INT_MONTH
													
													FROM SALES.SalesOrderHeader H 
														INNER JOIN SALES.SalesOrderDetail D ON H.SalesOrderID= D.SalesOrderID) 
																	
				SELECT CustomerID,YEAR_, 
					   NAME_OF_MONTH, 
					   COUNT(ORDERID) AS NO_OF_SALESORDER, 
					   CAST( SUM(LineTotal) AS decimal(10,3)) AS value_of_salesorder 
							
							FROM SALES_ORDERS	
								GROUP BY CustomerID, YEAR_, NAME_OF_MONTH, INT_MONTH 
									ORDER BY 1,INT_MONTH; 


** DESCRIPTION:
				To get total salesorder per month I extracted yeaar and month from the ordered date from orderheader table.
				Additionally I added  total values of that order by joinign with order detail table.
				Used subquery to extract the year and month, salesorderid, linetotal by joining header and detail tables 
					by using salesorderid as a key column.
				Sperated the subquery using cte for better readability.
				In main main query to get the total salesorder per month and their total value I used aggreagte function to acheive this.
				For aggrregation I grouped the year month column to get desired output.
				Cast function used to limit the deciimal value of toal value of sales order.
													