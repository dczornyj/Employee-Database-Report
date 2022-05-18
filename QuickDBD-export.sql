-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "Department_no" INT   NOT NULL,
    "DepartmentNAME" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "Department_no"
     )
);

CREATE TABLE "Employees by Department" (
    "Employee_no" INT   NOT NULL,
    "Department_no" INT   NOT NULL
);

CREATE TABLE "Department Manager" (
    "Department_no" INT   NOT NULL,
    "Employee_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "Employee_no" INT   NOT NULL,
    "TitleID" INT   NOT NULL,
    "birthdate" DATE   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Employee_no"
     )
);

CREATE TABLE "Salaries" (
    "Employee_no" INT   NOT NULL,
    "Salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "TitleID" INT   NOT NULL,
    "Title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "TitleID"
     )
);

ALTER TABLE "Employees by Department" ADD CONSTRAINT "fk_Employees by Department_Employee_no" FOREIGN KEY("Employee_no")
REFERENCES "Employees" ("Employee_no");

ALTER TABLE "Employees by Department" ADD CONSTRAINT "fk_Employees by Department_Department_no" FOREIGN KEY("Department_no")
REFERENCES "Departments" ("Department_no");

ALTER TABLE "Department Manager" ADD CONSTRAINT "fk_Department Manager_Department_no" FOREIGN KEY("Department_no")
REFERENCES "Departments" ("Department_no");

ALTER TABLE "Department Manager" ADD CONSTRAINT "fk_Department Manager_Employee_no" FOREIGN KEY("Employee_no")
REFERENCES "Employees" ("Employee_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_TitleID" FOREIGN KEY("TitleID")
REFERENCES "Titles" ("TitleID");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Employee_no" FOREIGN KEY("Employee_no")
REFERENCES "Employees" ("Employee_no");

