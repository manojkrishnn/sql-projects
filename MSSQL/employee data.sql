** AUTHOR	: MANOJ K
** DATE 	: 01-07-2024
** PRO.NAME	: TO GET THE EMPLOYEE HISTORY OF MAX WORKED DEPT AND SHIFT, TOTAL DEPT WORKED, TOTAL DAYS WORKED
** QUERY	:


			   WITH TOTALDEPTWORKED AS (SELECT BUSINESSENTITYID, 
												COUNT(DEPARTMENTID) AS TOTAL_DEPT_WORKED
													FROM HUMANRESOURCES.EMPLOYEEDEPARTMENTHISTORY 
														GROUP BY BUSINESSENTITYID),
														
				/*With clause 'total dept worked' is to get detail of how many dept does he worked in this company. 
					To acheive this I used aggregate function 'count' to count the departments by grouping businessentityid.*/														

					B AS (SELECT BUSINESSENTITYID, 
								 H. DEPARTMENTID, 
								 NAME, 
								 (DATEDIFF(DD,STARTDATE,ISNULL(ENDDATE, '2013-12-31'))+1) - (DATEDIFF(WK,STARTDATE,ISNULL(ENDDATE,'2013-12-31')))AS TOTAL_WORKED_DAYS
											FROM HUMANRESOURCES.EMPLOYEEDEPARTMENTHISTORY H 
													INNER JOIN HUMANRESOURCES.DEPARTMENT B ON H.DEPARTMENTID= B.DEPARTMENTID),
													
				/*With clause 'b' is to get total working days (except sunday) per department used date functions.we have some null values in end date column, 
							to change that as a defined value, I used isnull function to convert nulll values into given date value.
							Now using dattediff to find date diff between start and end date and no of week between those dates.
							By substracting both days and weeks we can get total working days per department. As a result we get total working days per dept.	*/								
													

					C AS (SELECT B.*,
								 ROW_NUMBER() OVER (PARTITION BY BUSINESSENTITYID ORDER BY  BUSINESSENTITYID ASC,TOTAL_WORKED_DAYS DESC, NAME ASC) AS ROW_N 
									FROM B),
									
					/*WITH CLAUSE 'c' IS to get max worked dept, to get those data we need to arrange the RESULTSET OF with clasue 'b' ordering by total worked days 
					in descending to get larger value first. for that we used analytical func 'row number' here.	*/						
									

					D AS (SELECT BUSINESSENTITYID, 
								 SHIFTID, 
								 COUNT(SHIFTID) AS REPEATED_SHIFT_WORKED, 
								 ROW_NUMBER() OVER (PARTITION BY BUSINESSENTITYID ORDER BY COUNT(SHIFTID) DESC) AS ORDERING
										FROM HUMANRESOURCES.EMPLOYEEDEPARTMENTHISTORY 
											GROUP BY BUSINESSENTITYID, SHIFTID ),
											
					/*WITH CLAUSE 'D' IS TO GET THE HOW MANY TIMES EMPLOYEE WORKED IN SMAE SHIFT IN HIS OVERALL TIME. SO FOR THAT I TOOK HUMANRESOURCES.EMPLOYEEDEPARTMENTHISTORY TABLE 
							AND USED AGGREGATE FUNC 'COUNT' TO COUNT THE SHIFTS BY GROUPING BUSSINESSENTITYID AND SHIFT ID . NOW WE HAVE TO ORDER THE REPEATED SHIFTS BY DESC TO GET THE HIGHEST WORKED SHIFT.
							FOR THAT I USED 'ROW NUMBER ' TO ORDER THEM. HERE I PARTITON BY BUSSINESSENTITYID, AND ORDER BY REPEATED SHIFTS

*/
					MAXSHIFTWORKED AS ( SELECT * 
											FROM D 
												WHERE ORDERING = 1),
												
												
					/*WITH CLAUSE 'MAXSHIFTWORKED' IS TO filter the result sets of with clause 'd'							
												
*/
					TOTALWORKINGDAYS AS (SELECT BUSINESSENTITYID, 
												SUM(TOTAL_WORKED_DAYS) AS NO_OF_WORKED_DAYS 
													FROM B 
														GROUP BY BUSINESSENTITYID),
														
					/*with clause 'TOTALWORKINGDAYS' is to get total working days of an employee. for tha we need process the resultset of with clause 'B'
							 now using aggreagte function 'sum' on the resultset of with clause 'B'  by grouping BUSINESSENTITYID .
							by using this aggreagte func we have total working days of each employee. */
																
														

					MAXSPENTDEPT AS (SELECT BUSINESSENTITYID, 
											C.DEPARTMENTID,
											NAME,
											TOTAL_WORKED_DAYS 
												FROM C 
													WHERE ROW_N =1) 
													
					/*WITH CLAUSE 'MAXSPENTDEPT' IS to get i which dept he worked more days. for that already we fetched those data in with clause 'c' 
							and arranged those data in decending order based on no of worked days in each dept i used filter on those data to fetch the first data in its group.
							by this we can get highest worked dept for each employee*/								


						SELECT M.BUSINESSENTITYID,
							   CONCAT(FIRSTNAME,' ',LASTNAME) AS EMPLOYEENAME, 
							   TOTAL_DEPT_WORKED ,
							   NO_OF_WORKED_DAYS, --DEPARTMENTID,
							   N.NAME AS MAX_WORKED_DEPT, 
							   P.NAME AS MAX_WORKED_SHIFT,
							   CONCAT((RIGHT(CONVERT(VARCHAR,STARTTIME ,100) , 7)) ,' - ',
											(RIGHT(CONVERT(VARCHAR,ENDTIME , 100), 7) )) AS   WORKING_HOURS
						
									FROM TOTALDEPTWORKED M 
											INNER JOIN TOTALWORKINGDAYS W ON  M.BUSINESSENTITYID = W.BUSINESSENTITYID
											INNER JOIN MAXSPENTDEPT N  ON M.BUSINESSENTITYID = N.BUSINESSENTITYID
											INNER JOIN MAXSHIFTWORKED S ON M.BUSINESSENTITYID = S.BUSINESSENTITYID
											INNER JOIN HUMANRESOURCES.SHIFT P ON S.SHIFTID = P.SHIFTID
											INNER JOIN PERSON.PERSON V ON  M.BUSINESSENTITYID= V.BUSINESSENTITYID

					/*HERE MERGED ALL THE WITH CLAUSE USING JOIN TO GET THE ATTRIBUTES IN SELECT CLASUE. 
							HERE I USED STRNG FUNCTIONS TO GET THE SHIFT TIME IN MOST UNDERSTANBLE FORMAT
							 CONVERT USED TO CONVERT THE DATE TO VARCHAR WITH THE 12 HR CLOCK USING AM , PM
							 RIGHT FUNC IS USED TO KEEP ONLY THE TIME AND TO TRIM THE DATE 
					
					*/