--CREATE statements:
SET SERVEROUTPUT ON;

--select 'drop table ', table_name, 'cascade constraints;' from user_tables;
--drop table 	EXECUTORS	cascade constraints;
--drop table 	DEPARTMENTS	cascade constraints;
--drop table 	ASSIGNMENTS	cascade constraints;

CREATE TABLE Departments (
id INTEGER not NULL,
department_name VARCHAR2(50 BYTE) not NULL,
manager_name VARCHAR2(25 BYTE) not NULL,
manager_surname VARCHAR2(25 BYTE) not NULL,
manager_pathronimic VARCHAR2(25 BYTE),
phone_number VARCHAR2(20 BYTE),

CONSTRAINT Departments_check_p_key PRIMARY KEY (id),
--check phone number matches regexpr template
CONSTRAINT Departments_check_number CHECK(REGEXP_LIKE (phone_number, '^(\(\d{3}\)|\d{3})(\s|\-)\d{3}$'))
);

CREATE TABLE Executors (
id INTEGER not NULL,
name VARCHAR2(25 BYTE) not NULL,
surname VARCHAR2(25 BYTE) not NULL,
pathronimic VARCHAR2(25 BYTE),
salary NUMBER(8, 2) not NULL,
department_id INTEGER,

CONSTRAINT Executors_check_p_key PRIMARY KEY (id),   --primary key constraint
CONSTRAINT Executors_check_f_key FOREIGN KEY (department_id) REFERENCES Departments(id), --foreign key constraint

CONSTRAINT Executors_check_salary_pos CHECK(salary > 0),  --salary can't be negative
CONSTRAINT Executors_check_id_pos CHECK(id >= 0)      --id is non negative
);

CREATE TABLE Assignments (
    id              INTEGER not null,
    note            VARCHAR2(50 BYTE),
    description     VARCHAR2(1000 BYTE),
    executor_id     INTEGER,
    completion_data DATE,
    execution_cost  NUMBER(8, 2) not NULL,
    done            VARCHAR2(1 BYTE) NOT NULL,
    CONSTRAINT Assignments_check_p_key PRIMARY KEY ( id ),             --primary key constraint
    CONSTRAINT Assignments_check_f_key FOREIGN KEY (executor_id) REFERENCES Executors(id), --foreign key constraint
    CONSTRAINT Assignments_check_pos_cost CHECK ( execution_cost >= 0 ),  --cost can't be negative
    CONSTRAINT Assignments_check_pos_id CHECK (id >= 0),                --id is non negative
    CONSTRAINT Assignments_check_done_mark CHECK(done = '0' or done = '1') --character flag represents boolean value
);

--fill Departments data
declare
    -- random id's generation
    id1 INTEGER := dbms_random.value(0, 5);
    id2 INTEGER := dbms_random.value(5, 10);
    id3 INTEGER := dbms_random.value(10, 15);
    id4 INTEGER := dbms_random.value(15, 20);
    id5 INTEGER := dbms_random.value(20, 25);
    id6 INTEGER := dbms_random.value(25, 30);
    id7 INTEGER := dbms_random.value(30, 35);
begin
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id1, 'Salary department', 'Sergey', 'Pavlov', 'Olegovich', '200-200');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id2, 'Supply department', 'Alexandr','Dotchenko', 'Andreevich', '(210) 200');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id3, 'Accounting department', 'Andrey','Validov', 'Andreevich', '(211)-100');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id4, 'Technical support department', 'Pavel','Birukov', 'Evgenievich', '(202) 103');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id5, 'IT department', 'Petr','Pavlichenko', 'Ivanovich', '201-201');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id6, 'Juridical department', 'Ivan','Ivanov', 'Pavlovich', '(203) 105');
INSERT INTO Departments (id, department_name, manager_name, manager_surname, manager_pathronimic, phone_number) VALUES(id7, 'Personnel department', 'Alexey','Demchuk', 'Vilipovich', '(220)-210');
end;

select * from executors;
select * from departments;
select * from assignments;

SET SERVEROUTPUT ON;

--fill executors table:
declare
    -- random id's generation
    id1 INTEGER := dbms_random.value(0, 5);
    id2 INTEGER := dbms_random.value(6, 10);
    id3 INTEGER := dbms_random.value(11, 15);
    id4 INTEGER := dbms_random.value(16, 20);
    id5 INTEGER := dbms_random.value(21, 25);
    id6 INTEGER := dbms_random.value(26, 30);
    id7 INTEGER := dbms_random.value(31, 35);
    id8 INTEGER := dbms_random.value(36, 40);
    id9 INTEGER := dbms_random.value(41, 45);
    id10 INTEGER := dbms_random.value(46, 50);
    -- random salary generation
    s1 NUMBER(8, 2) := dbms_random.value(15000, 20000);
    s2 NUMBER(8, 2) := dbms_random.value(25000, 30000);
    s3 NUMBER(8, 2) := dbms_random.value(35000, 40000);
    s4 NUMBER(8, 2) := dbms_random.value(45000, 50000);
    s5 NUMBER(8, 2) := dbms_random.value(55000, 60000);
    s6 NUMBER(8, 2) := dbms_random.value(65000, 70000);
    s7 NUMBER(8, 2) := dbms_random.value(75000, 80000);
    s8 NUMBER(8, 2) := dbms_random.value(100000, 120000);
    s9 NUMBER(8, 2) := dbms_random.value(120000, 130000);
    s10 NUMBER(8, 2) := dbms_random.value(130000, 140000);
begin
    --DBMS_OUTPUT.put_line(s1);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id1, 'Alexey', 'Sergeev', 'Pavlovich', s1, 1);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id2, 'Petr', 'Smolov', 'Sergeevich', s2, 33);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id3, 'Pavel', 'Polishuk', 'Pavlovich', s3, 9);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id4, 'Alexandr', 'Razuvaev', 'Petrovich', s4, 26);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id5, 'Andrey', 'Egorov', 'Vadimovich', s5, 12);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id6, 'Dmitriy', 'Vasilyev', 'Andreevich', s6, 17);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id9, 'Agata', 'Klimova', 'Sergeevna', s7, 17);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id10, 'Mariya', 'Lavronova', 'Pavlovna', s8, 22);    
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id7, 'Sergey', 'Fedotov', 'Alexandrovich', s9, 17);
    INSERT INTO executors(id, name, surname, pathronimic, salary, department_id) VALUES(id8, 'Roman', 'Ivanov', 'Vladimirovich', s10, 22);
end;

--fill Assignments table
declare
    -- random id's generation
    id1 INTEGER := dbms_random.value(0, 5);
    id2 INTEGER := dbms_random.value(6, 10);
    id3 INTEGER := dbms_random.value(11, 15);
    id4 INTEGER := dbms_random.value(16, 20);
    id5 INTEGER := dbms_random.value(21, 25);
    id6 INTEGER := dbms_random.value(26, 30);
    id7 INTEGER := dbms_random.value(31, 35);
    id8 INTEGER := dbms_random.value(36, 40);
    id9 INTEGER := dbms_random.value(41, 45);
    id10 INTEGER := dbms_random.value(46, 50);
    id11 INTEGER := dbms_random.value(101, 105);
    id12 INTEGER := dbms_random.value(76, 80);
    -- random cost generation
    c1 NUMBER(8,2) := dbms_random.value(7000, 8000);
    c2 NUMBER(8,2) := dbms_random.value(10000, 12000);
    c3 NUMBER(8,2) := dbms_random.value(10000, 13000);
    c4 NUMBER(8,2) := dbms_random.value(14000, 15000);
    c5 NUMBER(8,2) := dbms_random.value(18000, 20000);
    c6 NUMBER(8,2) := dbms_random.value(22000, 25000);
    c7 NUMBER(8,2) := dbms_random.value(30000, 31000);
    c8 NUMBER(8,2) := dbms_random.value(35000, 40000);
    c9 NUMBER(8,2) := dbms_random.value(50000, 51000);
    c10 NUMBER(8,2) := dbms_random.value(55000, 60000);
    c11 NUMBER(8,2) := dbms_random.value(30000, 32000);
    c12 NUMBER(8,2) := dbms_random.value(6800, 7000);
begin
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
    VALUES(id1, 'add to sale', 'add new goods to salary', 3, TO_DATE('13/11/2021', 'dd/mm,yyyy'), c1, '1');
    
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id2, 'select resumes', 'find out and select suitable resumes for technical department', 9, TO_DATE('3/12/2021', 'dd/mm,yyyy'), c2, '0');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done)
        VALUES(id3, 'orders delay', 'find out the reasons of orders delay', 14, TO_DATE('5/12/2021', 'dd/mm,yyyy'), c3, '0');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id4, 'integrate new form in documents', 'integrate medical insurance form in company jobs contracts', 17, TO_DATE('4/11/2021', 'dd/mm,yyyy'), c4, '1');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id5, 'summarize expenses for a month', 'summarize all expenses in departments for the last month, provide data to purchasing manager', 24, TO_DATE('5/11/2021', 'dd/mm,yyyy'), c5, '1');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id6, 'fix LAN communications', 'fix connection between Server and all PC in room-201, configure ssh-connection', 27, TO_DATE('23/10/2021', 'dd/mm,yyyy'), c6, '1');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id7, 'create new LAN', 'Configure router-A0 and all switches in room 202, test configured LAN in hight workload', 41, TO_DATE('17/11/2021', 'dd/mm,yyyy'), c7, '1');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id8, 'create new orders DB', 'Provide DB for new orders architecture', 48, TO_DATE('4/12/2021', 'dd/mm,yyyy'), c8, '0');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id9, 'Refactor local department connection safety', 'Refactor data encription type and provide new employees authentification polytic for this company department', 32, TO_DATE('27/11/2021', 'dd/mm,yyyy'), c9, '1');
        
    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id10, 'Provide new service in app', 'Integrate "smart" orders recomendation in app', 38, TO_DATE('7/12/2021', 'dd/mm,yyyy'), c10, '0');

    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id11, 'Increase order search performance', 'Refactor order search algorithm for performance increasing', 38, TO_DATE('13/11/2021', 'dd/mm,yyyy'), c11, '1');

    INSERT INTO assignments(id, note, description, executor_id, completion_data, execution_cost, done) 
        VALUES(id12, 'complaints considering', 'consider complaints on saled orders', 17, TO_DATE('25/11/2021', 'dd/mm,yyyy'), c12, '1');
        
end;
