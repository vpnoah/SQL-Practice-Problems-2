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