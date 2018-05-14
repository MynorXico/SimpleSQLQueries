/* Primero */
SELECT * FROM(
SELECT E.EMPLOYEE_ID, E.HIRE_DATE, D.DEPARTMENT_NAME, D.DEPARTMENT_ID, e.salary
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.HIRE_DATE DESC)
WHERE ROWNUM <= 1;

SELECT DEPARTMENT_ID, MAX(HIRE_DATE)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 2 DESC;

/* Segundo */
SELECT * FROM(
SELECT E.EMPLOYEE_ID, E.HIRE_DATE, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.HIRE_DATE LIKE '%08'
ORDER BY SALARY DESC)
WHERE ROWNUM < 2;

/* Ejercicio 3 */
select round(avg(e.salary), 2), department_id
from employees e where department_id is not null 
group by department_id;

/* Ejercicio 4 */
select sum(e.salary) MENSUAL, sum(e.salary)*12 ANUAL, e.department_id
from employees e
where e.department_id is not null
group by e.department_id;

/* Ejercicio 5 */
select * from(
select job_id, avg(salary)
from employees
group by job_id
order by avg(salary) desc)
where rownum < 2;

/* Ejercicio 6*/

select job_id, max(salary)-min(salary)
from employees
group by job_id
order by 1 desc;


/*
* Segunda hoja
*/

select COUNT(E.MANAGER_ID)
from EMPLOYEES e join DEPARTMENTS d on(e.EMPLOYEE_ID=d.manager_id)
GROUP by e.EMPLOYEE_ID;

select count(e.employee_id), m.employee_id, m.first_name
from employees e join employees m on(e.manager_id=m.employee_id)
join departments d on(e.manager_id = d.manager_id)
group by m.employee_id, m.first_name
having count(e.employee_id) = (select min(count(e.employee_id))
                                from employees e join employees m on(e.manager_id=m.employee_id)
                                join departments d on(e.manager_id = d.manager_id)
                                group by d.department_id);
                                
/* Segundo inciso*/


/*Mi solución*/
select d.department_name, e.first_name manager, e.hire_date
from departments d join employees e on (d.manager_id = e.employee_id)
where e.hire_date = (
        select max(e.hire_date)
            from employees e join departments d on(e.employee_id = d.manager_id)
            
    );
/* Karlo */
select d.department_name, m.first_name, m.last_name, m.hire_date
from departments d join employees m on (d.manager_id = m.employee_id)
where m.hire_date = (select max(hire_date) from departments d join employees m on (d.manager_id = m.employee_id));


select * from departments
where manager_id = 102;

/* Mi solución al tercero*/
select d.department_name, round(avg(e.salary), 2)
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id,d.department_name;
order by d.department_id;


/* Mi solución al cuarto */
select e.first_name NOMBRE_EMPLEADO, e.hire_date FECHA_EMPLEADO, m.first_name NOMBRE_JEFE
from employees e join employees m on (e.manager_id = m.employee_id)
where e.hire_date < m.hire_date
order by e.hire_date;

/*Maynor solution*/
select r.region_name, count(e.EMPLOYEE_ID)
from employees e join departments d on (e.department_id = d.department_id)
join locations l on(d.location_id = l.location_id)
join countries c on(l.country_id = c.country_id)
join regions r on (c.region_id = r.region_id)
group by r.region_id, r.region_name
order by 2 desc;

/* Karlo solution*/
select r.region_name, count(r.region_name) cantidad_empleados
from regions r join countries c on (r.region_id = c.region_id)
join locations l on (l.country_id = c.country_id)
join departments d on (d.location_id = l.location_id)
join employees e on (d.department_id = e.department_id)
group by r.region_name
order by 2 desc;

/* -------------------------------------- Comienzan */
/*1*/
select job_id, job_title, MIN_SALARY
from jobs
where MIN_SALARY>10000;
/*2*/
SELECT e.first_name, e.hire_date
FROM employees e
where e.hire_date between '01/01/2002' and '31/12/2004'
order by hire_date;
/*3*/
SELECT e.first_name, e.hire_date, e.job_id
FROM employees e
WHERE e.job_id = 'IT_PROG' or e.job_id = 'SA_MAN';
/*4*/
SELECT e.first_name, e.hire_date
FROM employees e 
WHERE e.hire_date >= '01/01/08';

/*5*/
SELECT * 
FROM employees e
WHERE e.employee_id = 150 or e.employee_id = 160;

/*6*/
SELECT e.first_name, e.salary, nvl(TO_CHAR(e.commission_pct), 'puto'), e.hire_date
FROM employees e
WHERE e.salary < 10000
ORDER by e.salary desc;

/*7*/
SELECT j.job_title, j.max_salary-j.min_salary as dif
FROM jobs j
WHERE j.max_salary between 10000 and 20000;

/*8*/
SELECT e.first_name, round(e.salary, -3)
FROM employees e;

/*9*/
SELECT *
FROM jobs
ORDER BY job_title desc;

/*10*/
SELECT *
FROM employees e
WHERE e.first_name like 'S%' or e.last_name like 'S%';

/*11*/
SELECT *
from employees e
WHERE e.hire_date LIKE '%/05/%';

/*12*/
select * from departments;
SELECT *
FROM employees e
where e.department_id = 30 and e.commission_pct is null and e.salary between 5000 and 10000;

SELECT * FROM JOB_HISTORY;
/*13*/
SELECT e.first_name, jh.start_date, e.employee_id,min(start_date)
FROM employees e join job_history jh on (e.employee_id = jh.employee_id)
GROUP BY e.employee_id, e.first_name, jh.start_date
ORDER BY jh.start_date, e.first_name, jh.start_date;

/*14*/
SELECT e.first_name name, round((sysdate - e.hire_date), 0) as Experiencia, sysdate, e.hire_date
FROM employees e;

/*15*/
SELECT e.first_name, e.hire_date
FROM employees e
WHERE e.hire_date LIKE '%01';

/*16*/
SELECT INITCAP(e.first_name), INITCAP(e.last_name)
FROM employees e;

/*17*/
SELECT j.job_title, nvl(substr(j.job_title, 1, instr(j.job_title, ' ')-1), j.job_title)
FROM jobs j;

/*18*/
SELECT j.job_title, length(nvl(substr(j.job_title, 1, instr(j.job_title, ' ')-1), j.job_title)) length
from jobs j;

/*19*/
desc employees;
SELECT upper(e.first_name), lower(e.email)
from employees e;
where upper(e.first_name)=upper(e.email);

/*20*/
SELECT *
FROM employees e
WHERE e.hire_date like '%18';

/*21*/
select round(sysdate-to_date('01/01/2011'),0)
from dual;

/*22 (asumiendo el año actual es 2002)*/
select count(e.employee_id), extract(month from e.hire_date)
from employees e
where extract(year from e.hire_date) like '%02'
group by extract(month from e.hire_date)
order by 2;

/*23*/
select m.employee_id, count(e.employee_id)
from employees m join employees e on(m.employee_id = e.manager_id)
group by m.employee_id
order by count(e.employee_id);

/*24*/
SELECT e.employee_id, jh.end_date
FROM employees e inner join job_history jh on(e.employee_id = jh.employee_id);

/*25*/
SELECT count(e.employee_id)
FROM employees e
WHERE extract(day from e.hire_date) > 15;

/*26*/
SELECT cn.country_id nCities, count(l.location_id)
FROM countries cn join locations l on(cn.country_id = l.country_id)
group by cn.country_id;

/*27*/
SELECT round(avg(e.salary),2), d.department_name
FROM employees e join departments d on(e.department_id = d.department_id)
WHERE e.commission_pct IS NOT NULL
GROUP BY d.department_name;

desc jobs;
/*28*/
SELECT count(e.employee_id), sum(e.salary), max(e.salary)-min(e.salary), j.job_title
FROM employees e join jobs j on(e.job_id = j.job_id)
group by e.job_id, j.job_title;

/*29*/
SELECT e.job_id, avg(e.salary)
FROM employees e
HAVING avg(e.salary) > 10000
group by e.job_id;

/*30*/
SELECT extract(year from e.hire_date), count(e.employee_id)
FROM employees e
HAVING count(e.employee_id) > 10
GROUP BY extract(year from e.hire_date);

/*31*/
select * from employees
where employee_id = 115;
UPDATE employees e
SET e.salary = 8000
where e.employee_id = 115 and e.salary < 6000;
;
select * from jobs;
insert into employees(employee_id, last_name, email, hire_date, job_id) values (10000, 'first_name', 'mynor', '1/2/05', 'AD_ASST');

select e.first_name, e.employee_id, j.job_title, j.max_salary - j.min_salary
FROM employees e left outer join jobs j on (e.job_id = j.job_id);

select j.job_title
from employees e join jobs j on(e.job_id = j.job_id)
where e.salary > 15000
group by j.job_title;

select e.salary, j.job_title
from employees e join jobs j on(e.job_id = j.job_id);

delete from departments
where department_id = 20;

/*31*/
SELECT d.department_id, d.department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
WHERE e.commission_pct > 0 or e.commission_pct is not null
GROUP BY d.department_id, d.department_name
HAVING count(e.employee_id) > 5;

desc job_history;


/*32*/
SELECT e.employee_id, e.first_name
FROM employees e JOIN job_history h ON (e.employee_id = h.employee_id)
GROUP BY e.employee_id, e.first_name;


/*33*/
desc jobs;
SELECT j.job_id 
FROM jobs j JOIN job_history e ON (j.job_id = e.job_id)
WHERE (e.end_date - e.start_date) > 100
GROUP BY j.job_id 
HAVING COUNT(e.employee_id) > 3;

/*34*/
SELECT d.department_id, extract(year FROM  e.hire_date), COUNT(e.employee_id)
FROM employees e JOIN departments d ON(d.department_id = e.department_id)
GROUP BY d.department_id, extract(year FROM e.hire_date)
ORDER BY department_id;

desc departments;
/* 35 */
SELECT d.department_id, d.department_name, d.manager_id
FROM departments d JOIN employees m ON (d.manager_id = m.employee_id)
JOIN employees e ON (e.manager_id = m.employee_id)
GROUP BY d.department_id, d.department_name, d.manager_id
HAVING count(e.employee_id) > 5;

/*36*/
UPDATE employees e
SET e.salary = 8000
WHERE e.employee_id = 115 and e.salary < 6000;

select * from jobs;
/*37*/
DESC EMPLOYEES;
INSERT INTO EMPLOYEES(employee_id, last_name, email, hire_date, job_id) VALUES(789, 'LAST_NAME_TEST', 'EMAIL_TEST', '01/01/03', 'AC_ACCOUNT');

/*38*/ /*Not valid because table doesn't support cascade deleting jeje */
DELETE EMPLOYEES E
WHERE E.DEPARTMENT_ID = 20;

/*39*/
UPDATE employees e
SET e.job_id = 'IT_PROG' 
where e.department_id = 10 and e.job_id NOT LIKE 'IT%';

/*40*/
SELECT * FROM LOCATIONS
ORDER BY CITY;

DESC DEPARTMENTS;
INSERT INTO DEPARTMENTS(manager_id,department_id, department_name) values(120, (
                                                                                SELECT location_id FROM
                                                                                LOCATIONS WHERE CITY LIKE 'Tokyo'
                                                                            ) , 'JEJE');
                                                                            
/*41*/
SELECT d.department_name, count(e.employee_id)
FROM departments d JOIN employees e ON (d.department_id = e.department_id)
GROUP BY d.department_name;

/*42*/
DESC job_history;
SELECT j.job_title, jh.employee_id, (jh.end_date - jh.start_date) WORKED_DAYS
FROM jobs j JOIN job_history jh ON (j.job_id = jh.job_id)
where jh.department_id = 30;

/*43*/
SELECT d.department_name, m.first_name
FROM departments d JOIN employees m ON (d.manager_id = m.employee_id);

/*44*/
DESC LOCATIONS;
SELECT d.department_name, m.first_name || ' ' || m.last_name MANAGER, l.city
FROM departments d JOIN employees m ON (d.manager_id = m.employee_id)
JOIN locations l ON (d.location_id = l.location_id);

/*45*/
SELECT c.country_name, l.city, d.department_name
FROM countries c JOIN locations l ON (c.country_id = l.country_id)
JOIN departments d ON (d.location_id = l.location_id);

/*46*/
DESC job_history;
SELECT j.job_title, d.department_name, e.last_name, jh.start_date, jh.end_date
FROM job_history jh JOIN jobs j ON (jh.job_id = j.job_id)
JOIN departments d ON (jh.department_id = d.department_id)
JOIN employees e ON (jh.employee_id = e.employee_id)
WHERE jh.start_date > '01/01/2000' and jh.end_date < '31/12/2005';

/*47*/
SELECT j.job_title, ROUND(avg(e.salary),2)
FROM jobs j JOIN employees e ON (j.job_id = e.job_id)
GROUP BY j.job_title
ORDER BY 1;

/*48*/
SELECT j.job_title, nvl(e.first_name, ' '), nvl(abs(j.max_salary - e.salary), 0) difference
FROM jobs j JOIN employees e ON (j.job_id = e.job_id);

/*49*/
SELECT e.last_name, j.job_title
FROM employees e JOIN jobs j ON (e.job_id = j.job_id)
WHERE e.commission_pct is not null and e.commission_pct > 0 and e.department_id = 30;

/*50*/
SELECT j.job_id, j.job_title
FROM job_history jh JOIN jobs j ON (jh.job_id = j.job_id)
JOIN employees e ON (e.employee_id = jh.employee_id)
WHERE e.salary = 17000
GROUP BY j.job_id, j.job_title;