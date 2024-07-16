** AUTHOR	: MANOJ K
** DATE 	: 18-06-2024
** PRO.NAME	: GET THE ORDERED DAY OF THE SALES ORDER.
**SQL QUERY	:
			
			SELECT SALESORDERID, ORDERDATE, DATENAME(WEEKDAY,ORDERDATE) AS ORDERED_DAY 
				FROM SALES.SALESORDERHEADER 
					ORDER BY SALESORDERID DESC;
					
**DESCRIPTION	
				--HERE OUR OBJECTIVE IS TO GET THE DAY OF ORDERED DATE.
				--SO I USED DATE FUNCTION CALLED 'DATENAME' TO GET THE DAY OF ORDERDATE
				--ARRANGED TABLE USING SALESORDERID AS A KEY COLUMN