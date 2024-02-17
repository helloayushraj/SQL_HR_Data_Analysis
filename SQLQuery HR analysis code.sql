select * from hrdata;


-- 1. Employee Count

select 
     sum(employee_count) as employee_count
from hrdata;

-- 2. Attrition Count

select 
      count(attrition) as attrition_count
from hrdata
where attrition = 'Yes';

--3.  Attrition Rate

select
       cast((select cast(count(attrition) as decimal(10,2)) from hrdata where attrition = 'Yes')*100/
	  sum(employee_count) as decimal (10,2)) as attrition_rate
from hrdata;


--4. Active Employee

select 
     count(employee_count) as active_employees
from hrdata
where attrition = 'No';

--5. Average Age

select 
      cast (avg(age) as decimal (10)) as avg_age
from hrdata;


--6. Attrition by Gender

select 
		gender, 
		count(attrition) as attrition_count
from hrdata 
where attrition = 'Yes'
group by gender
order by attrition_count desc;

--7. Department-Wise  Attrition

select 
		department, 
		count(attrition) as attrition_count,
		cast(cast(count(attrition) as decimal (10,2))*100/
		                   (select count(attrition) from hrdata where attrition = 'Yes')as decimal (10,2))  as attrition_rate
from hrdata 
where attrition = 'Yes'
group by department
order by count(attrition) desc;

--8. Job Satisfaction Ratings

select job_role,
sum(case when job_satisfaction = 1 then employee_count else null end ) as  '1st_star',
sum(case when job_satisfaction = 2 then employee_count else null end ) as '2st_star',
sum(case when job_satisfaction = 3 then employee_count else null end ) as '3st_star',
sum(case when job_satisfaction = 4 then employee_count else null end ) as '4st_star',
sum(employee_count) as total
from hrdata
group by job_role;


--9. Education Field Wise Attrition

select education_field,count(attrition) as attrition_count
from hrdata
where attrition = 'Yes'
group by education_field
order by attrition_count desc;

--10. Attrition Rate Gender for Different Age Group

select 
		age_band,
		gender,
		count(attrition) as attrition_count,
		cast((cast(count(attrition) as numeric))/
		             (select count(attrition) from hrdata where attrition = 'Yes') as decimal (10,2))*100 as attrition_rate
from hrdata
where attrition = 'Yes'
group by age_band,gender
order by age_band,gender;

-- 11. No of Employee by age-group

select
      age,
      sum(employee_count) as employee_count
from hrdata group by age
order by age;

--12. No of Employee by age-group and gender

select
		age_band,
		gender,
		sum(employee_count) as employee_count
from hrdata
group by age_band,gender
order by age_band asc, gender desc;


-- --------------------------------------------------------------------------------------------------------------------------




