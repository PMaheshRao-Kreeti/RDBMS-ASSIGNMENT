-- Postgresql

-- 1. Create a trigger to fill up the full_name column in the dependents table while inserting any new records.

Alter table dependents add column if not exists full_name varchar(255);

Create or replace function fill_full_name()
return trigger as 
$$
Begin
  new.full_name := concat(new.first_name,' ',new.last_name);
end;
$$ Language plpgsql;

Create trigger fill_full_name 
before insert on dependents
for each row execute function fill_full_name();

-- 2. Create a trigger that stores the transaction records of each insert, update and delete operations performed on the locations table into locations_info table

create table locations_info (
  id SERIAL PRIMARY KEY,
  operation VARCHAR(10) NOT NULL,
  location_id INT,
  street_address VARCHAR(255),
  pincode VARCHAR(10),
  city VARCHAR(255),
  state_province VARCHAR(255),
  country_id INT
);

create or replace function trg_locations_audit()
return trigger as 
$$
Begin
    IF TG_OP = 'INSERT' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('INSERT', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('UPDATE', NEW.location_id, NEW.street_address, NEW.pincode, NEW.city, NEW.state_province, NEW.country_id);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO locations_info (operation, location_id, street_address, pincode, city, state_province, country_id)
        VALUES ('DELETE', OLD.location_id, OLD.street_address, OLD.pincode, OLD.city, OLD.state_province, OLD.country_id);
        RETURN OLD;
    end if;
end;
$$ Language plpgsql;

create trigger trg_locations_audit
after insert OR update OR delete ON locations
for each row execute function trg_locations_audit();

-- 3. For the following tables create a view named employee_information with employee first name, last name, salary, department name, city, postal code insert only those records whose postal code length is less than 5.

create view employee_information as
select e.first_name, e.last_name, e.salary, d.department_name, l.city, l.pincode
from employees e inner join departments d 
  on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
  where length(l.pincode) < 5;

-- 4. Explain ACID properties with an example

The ACID properties of a Relational DBMS are:

1. Atomicity: this propert ensures that if the transcation takes place then it is completely extecuted. or if some error occure that the transaction doesnot take place at all.

For example, when someone do UPI transcation either the transaction is completed i.e. the amount is deducted and added to reciever account or if the transactions fails the deducted amoount get added to the sender account.

2. Consistency: This property ensures that a transaction moves the database from
one consistent state to another consistent state i.e. the database is always in a consistent state, maintaining data integrity of the database .

For example, 
let there are two user x and y 

user           x     y    total amt
initial amt   500   200     700
final amt     300   400     700

in the above transaction the user x send 200 to user y.
so before transcation the amount in user x and user y account is in total of 500+200=700.
and after the transaction it is 300+400=700.
which means the consistency is maintained.

3. Isolation: This property ensures that multiple transactions can execute
simultaneously without interfering with each other in database . Each transaction operates
as if it is the only transaction executing on the database, even if multiple 
transactions are executing concurrently.
no transaction is visible in the databse until it is completely commited.

4. Durability: This property makes sure that the changes commited to the database persist even if there are power outages.
i.e. due to some system error system shutdown in that case the data is get stores in the disk which will run when the system power on , and the consistency of database maintained. 

-- 5. Answer the above question with explanation

The Occupation column has been used to make the index. the Occupation column when sorted in asc order it will come in the mentioned index pattern 1,3,2,5,4 .




