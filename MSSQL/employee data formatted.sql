with totalDeptWorked
as (select BusinessEntityID,
           count(DepartmentID) as total_dept_worked
    from HumanResources.EmployeeDepartmentHistory
    group by BusinessEntityID
   ),
     B
as (select BusinessEntityID,
           H.DepartmentID,
           name,
           (datediff(dd, startdate, isnull(EndDate, '2013-12-31')))
           - (DATEdiff(wk, startdate, isnull(EndDate, '2013-12-31'))) as total_worked_days
    from HumanResources.EmployeeDepartmentHistory H
        inner join HumanResources.Department b
            on b.DepartmentID = H.DepartmentID
   ),
     c
as (select b.*,
           ROW_NUMBER() over (partition by BusinessEntityID
                              order by BusinessEntityID asc,
                                       total_worked_days desc,
                                       name asc
                             ) as row_N
    from B
   ),
     D
as (select BusinessEntityID,
           ShiftID,
           count(ShiftID) as repeated_shift_worked,
           row_number() over (partition by BusinessEntityID order by count(shiftid) desc) as ordering
    from HumanResources.EmployeeDepartmentHistory
    group by BusinessEntityID,
             ShiftID
   ),
     maxshiftworked
as (select *
    from d
    where ordering = 1
   ),
     totalWorkingDays
as (select BusinessEntityID,
           sum(total_worked_days) as no_of_worked_days
    from B
    group by BusinessEntityID
   ),
     maxSpentDept
as (select BusinessEntityID,
           c.DepartmentID,
           name,
           total_worked_days
    from c
    where row_N = 1
   )
select M.BusinessEntityID,
       concat(FirstName, ' ', LastName) as EmployeeName,
       total_dept_worked,
       no_of_worked_days,
       n.Name as max_worked_dept,
       p.Name as max_Worked_shift,
       Right(CONVERT(varchar, [StartTime], 100), 7) AS login_time,
       RIGHT(CONVERT(VARCHAR, [EndTime], 100), 7) AS logoff_time
from totalDeptWorked M
    inner join totalWorkingDays W
        on M.BusinessEntityID = W.BusinessEntityID
    inner join maxSpentDept N
        on M.BusinessEntityID = N.BusinessEntityID
    inner join maxshiftworked S
        on M.BusinessEntityID = S.BusinessEntityID
    inner join HumanResources.Shift P
        on s.ShiftID = p.ShiftID
    inner join Person.Person V
        on M.BusinessEntityID = V.BusinessEntityID
