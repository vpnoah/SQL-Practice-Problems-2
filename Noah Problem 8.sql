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