--CREATE OUR 6 TABLES USING EXPORT METHOD FROM QUICKDBD.COM
CREATE TABLE departments (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

--verify table departments was created successfully
SELECT * FROM departments


CREATE TABLE dept_emp (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

--verify table dept_emp was created successfully
SELECT * FROM dept_emp


CREATE TABLE dept_manager (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

--verify table dept_manager was created successfully
SELECT * FROM dept_manager


CREATE TABLE employees (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
--verify table employees was created successfully
SELECT * FROM employees


CREATE TABLE salaries (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);
--verify table salaries was created successfully
SELECT * FROM salaries
WHERE emp_no= 10005


CREATE TABLE titles (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);
--verify table titles was created successfully
SELECT * FROM titles

---RUN THESE STATEMENTS AFTER IMPORTING CSV FOR EACH TABLE
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
--JOIN SALARIES AND EMPLOYEES TABLES
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.emp_no = employees.emp_no

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date between '1/1/1986' and '12/31/1986';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
--JOIN dept_manager, departments, & employees
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM departments
INNER JOIN dept_manager ON 
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
--JOIN departments, dept_emp, & employees
SELECT departments.dept_name, dept_emp.emp_no, employees.first_name, employees.last_name
FROM departments
INNER join dept_emp ON
dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, dept_emp.emp_no, employees.first_name, employees.last_name
FROM departments
INNER join dept_emp ON
dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
WHERE departments.dept_name= 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
--Somehow use the below code from question 4:
--USE ORDERBY TO LIST ALL EMPLOYEES IN DEPARTMENT "DEVELOPMENT" FIRST THEN LIST ALL EMPLOYEES IN DEPARTMENT "SALES"
--TRANSITION FROM DEVELOPMENT TO SALES OCCURS AT ROW 85708
SELECT departments.dept_name, dept_emp.emp_no, employees.first_name, employees.last_name
FROM departments
INNER join dept_emp ON
dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
WHERE departments.dept_name= 'Sales' OR departments.dept_name= 'Development'
ORDER BY departments.dept_name='Development' DESC;

-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;