** AUTHOR	: MANOJ K
** DATE 	: 01-07-2024
** PRO.NAME	: cost analyze report for each product
** QUERY	:
------
				
				
				create or alter procedure product_cost_history 
				@productid varchar(50) 
				as
				/* Used if condtition because the input has data that sholud be printed or else human readable error message shold be displayed.
				So I wrote a sql query to count the productid based the parameter passed through where condition.
				
				If it has row the no of rows will be resulted. If it greater than 0 then the if condition will be executed , 
			if there is no data means else condtion will be displayed
							
						*/	
			if  (select count(productid) from production.product where cast( productid as varchar(50)) like @productid) != 0

							-- Combine the standardcost column from both tables.

									 with all_time_max_min as ( select productid, StandardCost from Production.Product
																union 
																select productid , StandardCost from Production.ProductCostHistory), 
																
							/* Getting the date differnece to find the duration of the cost. There is null values in both startdate and enddate columns
							so that usig the case function  if both are null then the value sholud be 0 otherwise I assigned date for only enddate's null value rows in else condition 
							and find the date diffrence*/
							
							
										  baseData as (select s.ProductID,
														s.standardcost ,
														case when startdate is null and enddate is null 
																	then 0 
															 else  datediff (dd,startdate, isnull(enddate, '2014-07-31')) end as total_days 
																		from  production.ProductCostHistory p 
																			right join all_time_max_min s on p.ProductID= s.ProductID),
																			
							/* To get the how many times the cost had been changed I counted the standardcost from with cluse all_time_max_min
							by grouping the product id
							
							*/																		

										  totalchangedTime as (select ProductID,
														(count(standardcost)) as changed_times from all_time_max_min group by ProductID),
														
							/* To get the max duration cost, we arranging the resultset of the base data with clause by grouping productid and standardcost.
							For that row number function is used
							*/								
														

										  b as (select ProductID, StandardCost , total_days ,
																	 row_number() over (partition by productid order by total_days desc, standardcost ) as ordering 
																		 from baseData),
																		 
							/* Now we need max duration of a cost holded, all time high cost of product, as well as minimum cost. For that I have taken resultset of basedata and 
							and used max function on every column by grouping the productid							
							*/	
										  resultset as(select productid,max(total_days) as highDuratio_of_cost,
																				isnull(max(StandardCost),0) as all_time_high,isnull(min(StandardCost),0) as all_time_low
																						from basedata group by ProductID)
							/* Now we are merging all the with clause by using inner join on clause of productid, 
							   to get the max holded cost we used row number for it, so filterd that in where clause and also  product id . Productid passed as parmeter 
							   
								As per requiremnet the paramter input need to get  single output or series of  output. 
								For integer its ok, but to get series of data we need use like operator.
								Like opeator wont accept integer ,so I changed the datattype of productid to nvarchar temporary in where condtion only.
							*/																	
									
												select R.ProductID ,changed_times,highDuratio_of_cost,b.StandardCost  ,all_time_high,all_time_low  
															from resultset R inner join totalchangedTime t on r.ProductID= t.ProductID   
															inner join b on b.ProductID = r.ProductID where ordering =1 and cast(r.productid as varchar(50)) like @productid
															
					else 
						print 'The entered series '+ replace (@productid,'%','')+' is not found'
					
													exec  product_cost_history @productid = '20'	;
													




												