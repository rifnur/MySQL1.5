# 3адание 1
# Запускаем на под 1 пользователем
USE employees;
LOCK TABLE salaries READ;
SELECT * FROM employees.salaries LIMIT 10

# Запускаем на под  пользователем
# SELECT выполниться, UPDATE,INSERT только после снятия блокировки 1  пользователем
SELECT * FROM employees.salaries LIMIT 10;

INSERT INTO `employees`.`salaries`
(`emp_no`,`salary`,`from_date`,`to_date`)
VALUES
(10001,10000,Curdate(),Curdate());

# Запускаем на под 1 пользователем
UNLOCK TABLES;

#3адание 2 
BEGIN;
SELECT @emp_no:=`emp_no`+1 FROM `employees`.`employees` order by `emp_no` desc Limit 1;

INSERT INTO `employees`.`employees`
(`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`)
VALUES
(@emp_no,'1984-04-02','Rifnur','Vakhitov',M,'2013-04-10');

INSERT INTO `employees`.`salaries`
(`emp_no`,`salary`,`from_date`,`to_date`)
VALUES  
(@emp_no,500000,current_date(),'9999-01-01');
COMMIT;

#3адание 3
EXPLAIN SELECT  DE.*,  EMP.*,SA.*
FROM dept_emp DE 
 JOIN salaries SA ON DE.emp_no = SA.emp_no
left JOIN employees EMP ON DE.emp_no = EMP.emp_no
left JOIN dept_manager DM ON EMP.emp_no = DM.emp_no
where 
DM.emp_no=EMP.emp_no  and 
EMP.emp_no =SA.emp_no and
SA.emp_no=DE.emp_no  
#and  DE.emp_no  = '43624'