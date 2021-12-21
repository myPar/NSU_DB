--SET SERVEROUTPUT ON;

--ACCEPT input_date DATE FORMAT 'dd/mm/yyyy' PROMPT 'Enter date:  '
--declare
--    d DATE;
--    var_id INTEGER;
--    var_surname VARCHAR2(25 BYTE);
--    var_executor_id INTEGER;
--    var_note VARCHAR2(50 BYTE);
--begin
    --d := TO_DATE('&input_date', 'dd/mm/yyyy');
    --DBMS_OUTPUT.put_line(d);
    
--end;
--1-- (???????? ?????? ? ?????? ???-? select'??, ? ??? ??????? ???????????????? ??????????????????)
define cur_date = SYSDATE;
--implement with one select:
--define d = &1;  --????? ??????? ????
SELECT note, surname FROM
Assignments
INNER JOIN Executors ON Assignments.executor_id = Executors.id WHERE(Assignments.completion_data <= TO_DATE(&cur_date, 'dd/mm/yyyy') and Assignments.done = 0);

--implement with two selects:
define d = &1;  --????? ??????? ????
Select note,surname FROM
(SELECT Assignments.note, Assignments.executor_id FROM Assignments     
WHERE Assignments.completion_data <= TO_DATE('&d', 'dd/mm/yyyy') and Assignments.done = 0) t1
INNER JOIN Executors t2 ON t1.executor_id = t2.id;

define d = &1;  --????? ??????? ????
SELECT note, surname FROM
Assignments
INNER JOIN (SELECT executors.id, Executors.surname FROM Executors) t2 ON Assignments.executor_id = t2.id WHERE(Assignments.completion_data <= TO_DATE('&d', 'dd/mm/yyyy') and Assignments.done = 0);

--2--
SELECT department_name, manager_surname FROM Departments WHERE id IN (
SELECT department_id FROM (SELECT Executors.id, Executors.department_id FROM Executors WHERE Executors.id IN (
SELECT Assignments.executor_id FROM Assignments WHERE Assignments.done = 0 GROUP BY Assignments.executor_id)));
--2 -fixed
define d = &1;
SELECT DISTINCT department_name, manager_surname FROM
Assignments a INNER JOIN Executors e ON a.executor_id = e.id
INNER JOIN departments d ON e.department_id = d.id
WHERE a.done = 0 and a.completion_data > TO_DATE('&d', 'dd/mm/yyyy');

define cur_date = SYSDATE;
SELECT DISTINCT department_name, manager_surname FROM
Assignments a INNER JOIN Executors e ON a.executor_id = e.id
INNER JOIN departments d ON e.department_id = d.id
WHERE a.done = 0 and a.completion_data < TO_DATE(&cur_date, 'dd/mm/yyyy');

--3--
SELECT department_name, manager_surname, executors_count, max_salary FROM
(SELECT COUNT(Executors.id) as executors_count, MAX(Executors.salary) as max_salary, Executors.department_id FROM Executors GROUP BY department_id HAVING(COUNT(Executors.id) >= 2)) t1
INNER JOIN (SELECT Departments.department_name, Departments.manager_surname, Departments.id FROM Departments) t2 ON t1.department_id = t2.id;

--4--
SELECT Assignments.completion_data, Assignments.executor_id, 
SUM(done) OVER (PARTITION BY executor_id ORDER BY completion_data RANGE UNBOUNDED PRECEDING)
FROM Assignments
ORDER BY executor_id, completion_data;

