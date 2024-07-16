** AUTHOR	: MANOJ K
** DATE 	: 18-06-2024
** PRO.NAME	: MONTH-WISE TOTAL SALESOREDER LIST AND ITS VALUE
** QUERY	:

				WITH SALES_ORDERS AS (SELECT H.SalesOrderID AS ORDERID,LineTotal,  YEAR(OrderDate) AS YEAR_, 
											 DATENAME (MONTH,ORDERDATE) AS NAME_OF_MONTH, MONTH(OrderDate) AS INT_MONTH
												FROM SALES.SalesOrderHeader H INNER JOIN SALES.SalesOrderDetail D 
													ON H.SalesOrderID= D.SalesOrderID) 
													
				SELECT	YEAR_, NAME_OF_MONTH, COUNT(ORDERID) AS NO_OF_SALESORDER, CAST(SUM(LineTotal) AS decimal(10,3)) AS value_of_salesorder 
					FROM SALES_ORDERS	
						GROUP BY YEAR_, NAME_OF_MONTH, INT_MONTH 
							ORDER BY 1,INT_MONTH; 

DESCRIPTION:
				--TO get total salesorder per month i extracted yeaar and month from the ordered date from orderheader table.
				--additionally i added  total values of that order by joinign with order detail table.
				--used subquery to extract the year and month, salesorderid, linetotal by joining header and detail tables 
				--	by using salesorderid as a key column.
				--sperated the subquery using CTE for better readability.
				--in main main query to get the total salesorder per month and their total value i used aggreagte function to acheive this
				--for aggrregation i grouped the year month column to get desired output.
				--cast function used to limit the deciimal value of toal value of sales order