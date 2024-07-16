** AUTHOR	: MANOJ K
** DATE 	: 28-06-2024
** PRO.NAME	: TO FIND TOTAL SAUNDAY TO SATURDAY OF ALL DAYS BETWEEN TWO DATES USING CURSOR WITH PARAMETERS

** QUERY	:
				CREATE OR ALTER PROCEDURE NO_OF_DAYS_WITHPARA 
				@STARTDATE DATE,
				@STOPDATE DATE 
				AS


				DECLARE @ORDERDATE DATE
				DECLARE @SHIPDATE DATE
				DECLARE @DATE DATE
				DECLARE @WEEKDAY INT
				DECLARE @SUNDAY INT =0
				DECLARE @MONDAY INT =0
				DECLARE @TUESDAY INT=0
				DECLARE @WEDNESDAY INT=0
				DECLARE @THURSDAY INT=0
				DECLARE @FRIDAY INT=0
				DECLARE @SATURDAY INT=0
				DECLARE PARA_CUS CURSOR FOR 
											SELECT ORDERDATE,SHIPDATE FROM (SELECT @STARTDATE AS ORDERDATE,@STOPDATE AS SHIPDATE) AS A 

				OPEN PARA_CUS
				FETCH NEXT FROM PARA_CUS INTO @ORDERDATE, @SHIPDATE
				WHILE @@FETCH_STATUS=0
					BEGIN
							SET @DATE = @ORDERDATE
							WHILE (@DATE<=@SHIPDATE)
							BEGIN
								SET @WEEKDAY = DATEPART(DW,@DATE)
									IF		 @WEEKDAY = 1
											 
											SET @SUNDAY = @SUNDAY+1
											
									ELSE IF  @WEEKDAY = 2
											
											SET @MONDAY = @MONDAY+1
											
									ELSE IF  @WEEKDAY = 3
											
											SET @TUESDAY = @TUESDAY+1						-- USED IF CONDITION TO MATCH THE RESULT AND ADD 1 TO COLUMN BASED ON THE CONDITION
											
									ELSE IF  @WEEKDAY = 4
											
											SET @WEDNESDAY = @WEDNESDAY+1
							
									ELSE IF  @WEEKDAY = 5
											
											SET @THURSDAY = @THURSDAY+1
											
									ELSE IF  @WEEKDAY = 6
											
											SET @FRIDAY = @FRIDAY+1
											
									ELSE
											
											SET @SATURDAY = @SATURDAY+1
											
								SET @DATE = DATEADD(DAY,1,@DATE)
							END
		
							PRINT'NO.OF.SUNDAYS		:' + STR(@SUNDAY)
							PRINT'NO.OF.MONDAYS		:' + STR(@MONDAY)
							PRINT'NO.OF.TUESDAYS		:' + STR(@TUESDAY)
							PRINT'NO.OF.WEDNESDAYS	:' + STR(@WEDNESDAY)						
							PRINT'NO.OF.THURSDAYS		:' + STR(@THURSDAY)
							PRINT'NO.OF.FRIDAYS		:' + STR(@FRIDAY)
							PRINT'NO.OF.SATURDAYS		:' + STR(@SATURDAY)
							PRINT'NO.OF.YEARS			:'+ STR((@SUNDAY+@MONDAY+@TUESDAY+@WEDNESDAY+@THURSDAY+@FRIDAY+@SATURDAY)/365)
						FETCH NEXT FROM PARA_CUS INTO @ORDERDATE, @SHIPDATE

					END

				CLOSE PARA_CUS
			DEALLOCATE PARA_CUS

				--done

					EXEC no_of_days_withPara @STARTDATE = '2024-06-17' ,@stopdate = '2024-06-28'



									