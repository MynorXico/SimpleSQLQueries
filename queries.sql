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