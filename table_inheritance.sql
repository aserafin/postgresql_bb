drop table contractors;
drop table employees;

create table employees (
  name varchar,
  email varchar
);

create table contractors (
  invoice_prefix varchar
) inherits (employees);

truncate employees; truncate contractors;

insert into employees values ('Jonh Employee', 'employee@example.com');
insert into contractors values('John Contractor', 'contractor@example.com', 'C');


select * from employees;

select * from contractors;

select * from only employees;
