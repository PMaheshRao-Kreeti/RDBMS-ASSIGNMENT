-- all commands are used in postgresql

-- 1) Creating given schema as per the assignment


CREATE TABLE regions(
  region_id SERIAL PRIMARY KEY,
  region_name varchar(255)
);

CREATE TABLE countries(
  country_id SERIAL PRIMARY KEY,
  country_name varchar(255),
  region_id integer NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations(
  location_id SERIAL PRIMARY KEY,
  street_address varchar(255),
  postal_code varchar(10),
  city varchar(255),
  state_province varchar(255),
  country_id integer NOT NULL,
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE jobs(
  job_id SERIAL PRIMARY KEY,
  job_title varchar(255),
  min_salary integer,
  max_salary integer,
  CHECK(min_salary > 1000)
);


CREATE TABLE departments(
  department_id SERIAL PRIMARY KEY,
  department_name varchar(255),
  location_id integer,
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE employees(
  employee_id SERIAL PRIMARY KEY,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  email varchar(255),
  phone_number varchar(10),
  hire_date date,
  job_id integer NOT NULL,
  salary integer,
  manager_id integer NOT NULL,
  department_id integer,
  FOREIGN KEY (job_id) REFERENCES jobs(job_id),
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE dependents(
  dependent_id SERIAL PRIMARY KEY,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  relationship varchar(255),
  employee_id integer NOT NULL,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


--2) Inserting data into table as per the given assignment
INSERT INTO jobs(job_title,min_salary,max_salary) VALUES 
('SDE',50000,90000),('Manager',40000,80000),
('IOT',90000,120000),('DevOps',30000,90000),
('Data Scientist',60000,80000);


INSERT INTO regions(region_name) VALUES ('ASIA'),
('AFRICA'),('SOUTHEAST ASIA'),
('EUROPE'),('SOUTH ASIA');


INSERT INTO countries(country_name,region_id) VALUES ('INDIA',1),('UAE',2),('MALAYSIA',3),('UK',4),('CHINA',5);


INSERT INTO locations(street_address,postal_code,city,state_province,country_id) 
VALUES ('10 STREET','245878','RANCHI','JHARKHAND',1),
('50 STREET','712383','DUBAI','ABU DHABI',2),
('20 STREET','723047','KUALA LAMPUR','KUALA LAMPUR',3),
('30 STREET','873932','HUWAI','HUWAI',5),
('40 STREET','934567','LONDON','LONDON',4);


INSERT INTO department(department_name,location_id) VALUES 
('HR',1),('OPERATION',2),('MARKETING',4),('SLAES',3),('ADMIN','5');


INSERT INTO employees(first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES
('KARAN','SINGH','karan@gmail.com','8390209830','2017-10-19',2,50000,null,4),
('KARAN','KING','ran@gmail.com','8393209830','2019-12-12',5,50000,6,4),
('AMAN','HOSH','aman@gmial.com','7692345567','2022-07-24',4,800000,6,2),
('KARAM','DITA','am@gmail.com','7982463123','2015-09-13',1,65000,3,5),
('LAXMAN','GHOSH','laxman@gmial.com','7892345567','2015-04-26',1,60000,null,5),
('AVIALASH','CHAMAN','avi@gmail.com','9784643673','2023-04-19',4,100000,3,2),
('AVI','MAN','avi7@gmail.com','9794643673','2021-04-19',3,80000,null,1),
('MIT','SAH','mit@gmail.com','7658446456','2022-09-04',2,55000,6,3)
('RAM','PANDIT','ram@gmail.com','7985463123','2019-05-23',3,70000,null,3),
('AMIT','SAH','amit@gmail.com','7658946456','2022-08-04',5,40000,3,1),;



INSERT INTO dependents(first_name,last_name,relationship,employee_id) VALUES ('JOHN','WICK','FATHER',4),
('PRIYA','PANDIT','MOTHER',3),('PUJA','SINGH','WIFE',1),('MITA','GHOSH','WIFE',2),('SURBHI','KUMARI','MOTHER',8);


--3 a) In departments table, add a new field 'manager_name' of type VARCHAR
ALTER TABLE departments ADD manager_name varchar(255);

--3 b) REMOVE field max_salary from jobs. 
ALTER TABLE jobs DROP COLUMN max_salary;

--3 c) In the locations table, rename postal_code column to pincode.
ALTER TABLE locations RENAME COLUMN postal_code TO pincode;


--CONSTRAINTS

--4 a) SETTING NOT NULL to first_name and last_name
ALTER TABLE employees ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE employees ALTER COLUMN last_name SET NOT NULL;


--4 b) Min_salary must be greater than 1000
ALTER TABLE jobs ADD CHECK(min_salary > 1000);

--4 c) Max length of postal_code should be 10.
ALTER TABLE locations ALTER COLUMN pincode TYPE varchar(10);
