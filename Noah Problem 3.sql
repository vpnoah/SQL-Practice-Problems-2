alter table invoice drop foreign key invoice_ibfk_1;
alter table customer modify column cust_num int(11) auto_increment;
alter table customer auto_increment = 2000;
alter table invoice ADD FOREIGN KEY (cust_num) REFERENCES customer(cust_num);
alter table invoice modify column inv_num int(11) auto_increment;
alter table invoice auto_increment = 9000;