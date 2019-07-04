-- need to first install extension from https://github.com/EnterpriseDB/mysql_fdw
CREATE EXTENSION IF NOT EXISTS mysql_fdw;

CREATE SERVER local_mysql_server
     FOREIGN DATA WRAPPER mysql_fdw
     OPTIONS (host '127.0.0.1', port '3306');

CREATE USER MAPPING FOR aserafin
SERVER local_mysql_server
OPTIONS (username 'aserafin', password 'test123test');

CREATE FOREIGN TABLE mysql_users(
     name varchar,
     email varchar)
SERVER local_mysql_server
     OPTIONS (dbname 'postgresql_bb', table_name 'users');

-- we can query tables from the mysql server
select * from mysql_users;

-- we can insert data into foreign tables
insert into mysql_users values('John Smith', 'smith@example.com');

-- we can even perform joins with local postgresql tables and remote mysql tables
select * from mysql_users, users where mysql_users.email = users.email;
