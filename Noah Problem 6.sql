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
