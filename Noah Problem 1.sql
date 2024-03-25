drop schema if exists ch08_simpleco;
create schema ch08_simpleco;
use ch08_simpleco;

create table customer(
cust_num int(11) primary key,
cust_lname varchar(30),
cust_fname varchar(30),
cust_balance decimal(8,2)
);

create table invoice(
inv_num int(11) primary key,
cust_num int(11),
inv_date date,
inv_amount decimal(10,2),
foreign key (cust_num) references customer(cust_num) 
);
