** AUTHOR	: MANOJ K
** DATE 	: 24-07-2024
** PRO.NAME	: To find the no of working days between two dates
** QUERY	:	

				select  convert(date,orderdate,3) as orderdate, 
						convert(date,shipdate,3) as shipdate,
						datediff(dd, orderdate, shipdate) AS TOTAL_DAYS, 
						datediff (ww,OrderDate,ShipDate)*2 AS TOTAL_WEEKENDS,
						case
								when (datepart(WEEKDAY,orderdate) in (1) and datepart(WEEKDAY,shipdate) in (7))	
								
												
										then (DATEDIFF(dd,OrderDate,ShipDate)-1)- (datediff (ww,OrderDate,ShipDate)*2)
										
				
								when (datepart(WEEKDAY,orderdate) not in (1) and datepart(WEEKDAY,shipdate)  NOT in (7))
								
												
										then (DATEDIFF(dd,OrderDate,ShipDate)+1)- (datediff (ww,OrderDate,ShipDate)*2)
										
					
								else (DATEDIFF(dd,OrderDate,ShipDate))- (datediff (ww,OrderDate,ShipDate)*2) 
								
								end  as WORKING_DAYS

								from Purchasing.PurchaseOrderHeader 
					-- (select '2013-02-12' as orderdate, '2013-03-09' as shipdate) as a