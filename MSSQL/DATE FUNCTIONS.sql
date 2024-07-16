** AUTHOR	: MANOJ K
** DATE 	: 18-06-2024
** PRO.NAME	: ALL DATE FUNCTIONS
**SQL QUERY	:

		1. TO GET PART OF THE DATE SEPERATLY ( INTEGER):

	 SELECT DATEPART(YY,GETDATE()); 		& SELECT YEAR(GETDATE());		 & SELECT DATEPART(YEAR,GETDATE());	     -- TO GET YEAR FROM DATE

	 SELECT DATEPART(MM,GETDATE()); 		& SELECT MONTH(GETDATE()); 		 &  SELECT DATEPART(MONTH,GETDATE());		 -- TO GET MONTH FROM A DATE
	 
	 SELECT DATEPART(DD,GETDATE()); & SELECT DAY(GETDATE()); & SELECT DATEPART(DAY,GETDATE());			 -- TO GET DAY FROM A DATE

	 SELECT DATEPART(DW,GETDATE()); & SELECT DATEPART(WEEKDAY, GETDATE());								 -- TO GET NTH DAY OF A WEEK FROM A DATE
	 
	 SELECT DATEPART(WEEK,GETDATE()); & SELECT DATEPART(WK,GETDATE()); &  SELECT DATEPART(WW,GETDATE()); --TO GET NTH WEEK OF A YEAR FROM DATE

	 SELECT DATEPART(DY,GETDATE()); & SELECT DATEPART(DAYOFYEAR,GETDATE());								 --TO GET NTH DAY OF A YEAR FROM DATE

	    2.	TO GET PART OF DATE IN STRING
	 SELECT DATENAME(DW,GETDATE()); & SELECT DATENAME(WEEKDAY,GETDATE());  -- TO GET MONTH IN STRING (EG: Monday)

	 SELECT DATENAME(MM, GETDATE()); & SELECT DATENAME(MONTH, GETDATE());  -- TO GET THE NAME OF DAY ( EG: May)

		3. adding date from date 

	 SELECT DATEADD(MONTH, 10, GETDATE()); & SELECT DATEADD(MM, 10, GETDATE());											-- TO ADD MONTH FROM DATE

	 SELECT DATEADD(YEAR, 10, GETDATE()); & SELECT DATEADD(YY, 10, GETDATE());											-- TO ADD YEAR FROM DATE
	 
	 SELECT DATEADD(DAYOFYEAR, 10, GETDATE()); & SELECT DATEADD(DY, 10, GETDATE()); & SELECT DATEADD(DAY,10,GETDATE()); -- TO ADD DATE IN DATE

	 SELECT DATEADD(WEEK, 10, GETDATE()); & SELECT DATEADD(WK, 10, GETDATE()); & SELECT DATEADD (WW, 10,GETDATE());		-- TO ADD WEEKS FROM DATE

	  4. TO GET DIFF BW TWO DATES.

	 SELECT DATEDIFF(YY, GETDATE(), GETDATE()+365); & SELECT DATEDIFF(YEAR, GETDATE(), GETDATE()+365);   -- FIND DIFF BW YEARS

	 SELECT DATEDIFF(MM, GETDATE(), GETDATE()+365); & SELECT DATEDIFF(MONTH, GETDATE(), GETDATE()+365);  -- FIND DIFF BW MONTHS

	 SELECT DATEDIFF(DD, GETDATE(), GETDATE()+365); & SELECT DATEDIFF(DAY, GETDATE(), GETDATE()+365);    -- FIND DIFF BW DAYS

	 SELECT DATEDIFF(WW, GETDATE(), GETDATE()+365); & SELECT DATEDIFF(WEEK, GETDATE(), GETDATE()+365);   -- FIND DIFF BW WEEKS
	 
	  5. FIND LAST DAY OF MONTH.

	 SELECT EOMONTH (GETDATE(),2);  -- TO GET LAST DAY OF MONTH
	  
	  6. FORMATING THE DATE.

	 SELECT FORMAT(GETDATE(), 'D', 'en-US'); -- TO CHANGE THE DATE FORMAT OF GIVE DATE 

	  7. GET DATE WITH TIME STAMP.

	 SELECT CURRENT_TIMESTAMP( SELECT GETDATE());

	  8. TO FETCH SERVER DATE.

	 SELECT GETDATE();

	  9. TO GET SERVER DATE WITH TIME.

	 SELECT SYSDATETIME();

	 10.TO add time with WITH time.

	 SELECt switchoffset(getdate(),+1)


	 