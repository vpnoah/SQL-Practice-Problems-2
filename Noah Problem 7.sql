delimiter $$
create procedure prc_cust_add(w_cn int(11), w_ln varchar(30), w_fn varchar(30), w_cb int(11), w_dob date)
begin
	insert into customer values(w_cn, w_ln, w_fn, w_cb, w_dob);
end;$$
delimiter ;

call prc_cust_add(1002,"Rauther", "Peter", 0.00, "1970-01-01");

select * from customer