** AUTHOR	: MANOJ K
** DATE 	: 18-06-2024
** PRO.NAME	: GET NO OF WORKING DAYS BETWEEN ORDERDATE.
**SQL QUERY	:

				 select convert(date,orderdate,3) as orderdate, convert(date,shipdate,3) as shipdate,
						datediff(dd, orderdate, shipdate), datediff (ww,OrderDate,ShipDate)*2,
						case
							when (datepart(WEEKDAY,orderdate) in (1) and datepart(WEEKDAY,shipdate) in (7))
									
									then (DATEDIFF(dd,OrderDate,ShipDate)-1)- (datediff (ww,OrderDate,ShipDate)*2)
	
							when (datepart(WEEKDAY,orderdate) not in (1) and datepart(WEEKDAY,shipdate) in (7))
									OR 
								(datepart(WEEKDAY,orderdate)  in (1) and datepart(WEEKDAY,shipdate) not in (7))

									then(DATEDIFF(dd,OrderDate,ShipDate))- (datediff (ww,OrderDate,ShipDate)*2)
		
							else (DATEDIFF(dd,OrderDate,ShipDate)+1)- (datediff (ww,OrderDate,ShipDate)*2) 
							end  as working_days

					from Purchasing.PurchaseOrderHeader 
					-- (select '2013-02-12' as orderdate, '2013-03-09' as shipdate) as a

DESCRIPTION:
				/*
				1. IN SELECT CLAUSE ORDERDATE AND SHIPDATE FORMAT IS CHANGED FROM ITS ORIGINALITY  FOR BETTER READABILITY,
					FOR OUR REFERENCE I ADDED TOTAL NO OF DAYS AND TOTAL WEEKS OF TWO DATES

				2.WE NEED THREE CONDITION TO GET THE EXACT WORKING DAYS

					1. (SUNDAY - WEEKDAYS) AND (EXCEPT SUNDAY - SATURDAY) IS 0
					2. (SUNDAY  AND SATURDAY) IS -1
					3.	FOR  THE REST OF DAYS , WE NEED +1

				3. TO GET THE WORKING DAYS FROM A WEEK, FIRST WE NEED NO OF NON WORKING DAYS, TO GET THOSE INFORMATION,  
					HERE I USED DATEDIFF FUNCTION TO GET THE NO OF WEEKS THAT BETWEEN THE TWO DATES AND
						MULTIPLIED INTO 2, SO NOW WE GET HOW MANY NON WORKING DAYS B/W THOSE DATES

				       datediff (ww,OrderDate,ShipDate)*2

				4. NOW WE NEED TO GET NO OF DAYS  B/W THOSE DATES. TO GET THE TOTAL NO OF DATES 
					  
					  DATEDIFF(dd,OrderDate,ShipDate)

				5. NOW  SUBSTRACT TOTAL NO OF DAYS  WITH NO OF  NON WORKING DAYS. 

				6. BY USING THIS CONDITION WE CAN GET RESULT, BUT THE RESULT WILL BE IN DEVIATION FROM -1 DAY TO +1 DAY
					SO THAT WE NEED TO APPLY CONDTTION BASED ON THE START DATE AND END DATE.

				7. TO APPLY THOSE CONDTION I USED CASE STATEMENT IN THIS QUERY.

				8. WHEN THE ONE OF THE  CONDITION MATCHS WHICH MENTIONED IN THE 2ND POINT 
					THE DEVIATION SHOLUD BE ADDED WITH WITH THE RESULT  
