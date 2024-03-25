alter table customer add cust_dob date;

update customer
set cust_dob = "1989-03-15" 
where cust_num = 1000;

update customer
set cust_dob = "1988-12-22" 
where cust_num = 1001;

select * from customer;