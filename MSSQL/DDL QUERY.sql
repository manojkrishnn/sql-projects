** Author 	: MANOJ K
** DATE		: 19-06-2024
** DESCRI	: DDL COMMANDS		



create table adress_details (address_id varchar(4), full_adress varchar(225));


create table sample_ (member_id varchar (225) ,
member_name varchar(225) not null
,email varchar(225) unique,
ssn_id int ,address_id varchar(4)
primary key (member_id, ssn_id ),
constraint fk_address_id foreign key (address_id) references adress_details(address_id),
constraint cc_member_id check (member_id>1000)
);


 -- alter

 alter table sample_ --alter column address_id varchar(4) not null
 --add constraint pk_address_id  primary key(address_id)
 --alter column address_id smallint;
--add constraint cc_member_id check (member_id> 1100)
--drop constraint cc_member_id 
  add  country varchar(50); 

  drop table sample_;

  TRUNCATE table SAMPLE_;
  