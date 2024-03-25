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

insert into customer values(1000, "Smith", "Jeanne", 1050.11);
insert into customer values(1001, "Ortega", "Juan", 840.92);

insert into invoice values (8000,1000,'2016-03-23', 235.89);
insert into invoice values (8001,1001,'2016-03-23', 312.82);
insert into invoice values (8002,1001,'2016-03-30', 528.10);
insert into invoice values (8003,1000,'2016-04-12', 194.78);
insert into invoice values (8004,1000,'2016-04-16', 619.44);

alter table invoice drop foreign key invoice_ibfk_1;
alter table customer modify column cust_num int(11) auto_increment;
alter table customer auto_increment = 2000;
alter table invoice ADD FOREIGN KEY (cust_num) REFERENCES customer(cust_num);
alter table invoice modify column inv_num int(11) auto_increment;
alter table invoice auto_increment = 9000;

insert into customer values(null, "Powers", "Ruth", 500.00);
select * from customer;
insert into invoice values(null, 2000, "2016-05-05", 500.00);
select * from invoice;

alter table customer add cust_dob date;

update customer
set cust_dob = "1989-03-15" 
where cust_num = 1000;

update customer
set cust_dob = "1988-12-22" 
where cust_num = 1001;

select * from customer;

delimiter $$
create trigger trg_updatecustbalance
after insert on invoice
for each row
begin
	update customer
    set cust_balance = cust_balance + new.inv_amount
    where cust_num = new.cust_num;
end;$$
delimiter ;

insert into invoice values(8005,1001,"2018-04-27", 225.4);

select * from customer;

delimiter $$
create procedure prc_cust_add(w_cn int(11), w_ln varchar(30), w_fn varchar(30), w_cb int(11), w_dob date)
begin
	insert into customer values(w_cn, w_ln, w_fn, w_cb, w_dob);
end;$$
delimiter ;

call prc_cust_add(1002,"Rauther", "Peter", 0.00, "1970-01-01");

select * from customer

delimiter $$
create procedure prc_inv_add (p_in int(11), c_in int(11), p_d date, p_amt int(11))
begin 
	insert into invoice values(p_in, c_in, p_d, p_amt);
end;$$
delimiter ;

call prc_inv_add(8006,1000,"2018-04-30", 301.72);
select customer.cust_num, cust_balance, inv_num, inv_amount
from customer join invoice on customer.cust_num = invoice.cust_num
where customer.cust_num = 1000;

delimiter $$
create trigger trg_updatecustbalance2
after delete on invoice
for each row
begin
	update customer
    set cust_balance = cust_balance - old.inv_amount
    where cust_num = old.cust_num;
end; $$
delimiter ;

delimiter $$
create procedure prc_invoice_delete(p_in int(11))
begin
	delete from invoice
    where invoice.inv_num = p_in;
end; $$
delimiter ;

call prc_invoice_delete(8005);

select customer.cust_num, cust_balance, inv_num, inv_amount
from customer join invoice on customer.cust_num = invoice.cust_num
where customer.cust_num = 1001;