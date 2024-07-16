 select orderdate, shipdate , datediff(dd, orderdate, shipdate), 
	datediff (ww,OrderDate,ShipDate)*2,
 
 case 
 when (datepart (ww,OrderDate) in (7) and datepart (WEEK,OrderDate) not in (1,7)) 
		or(datepart (ww,OrderDate) in (7) and datepart (ww,OrderDate)  in (1))
		or (datepart (ww,OrderDate) in (7) and datepart (ww,OrderDate)  not in (1,7))

	then  (DATEDIFF(dd,OrderDate,ShipDate)+1)- (datediff (ww,OrderDate,ShipDate)*2)

 when 	(datepart (ww,OrderDate)  not in (1,7) and datepart (WEEK,OrderDate) in (7)) 
		or(datepart (ww,OrderDate) in (1) and datepart (ww,OrderDate)  in (7))
		
		then  (DATEDIFF(dd,OrderDate,ShipDate)-1)- (datediff (ww,OrderDate,ShipDate)*2)
		else
		 (DATEDIFF(dd,OrderDate,ShipDate))- (datediff (ww,OrderDate,ShipDate)*2)
	end  as working_days

 from Purchasing.PurchaseOrderHeader -- (select '2024-07-0' as orderdate, '2024-08-13' as shipdate) as a
