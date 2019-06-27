drop table if exists contractors;
drop table if exists employees;
drop table if exists users;

create table users (
  name varchar,
  email varchar
);

create table employees (
  bank_id integer
) inherits (users);

insert into employees values('Xavi Caballe', 'xavi@whitespectre.com', 1);

select * from employees;

select * from users;

create table contractors (
  invoice_prefix varchar,
  beneficiary_name varchar,
  beneficiary_address varchar
) inherits (employees);

insert into contractors values('Adrian Serafin', 'adrians@whitespectre.com', 1, 'AS', 'SOFTMAD', 'POLAND')

select * from contractors;

select * from users;

select * from employees;

select * from only employees;
