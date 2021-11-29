drop table if exists admins, customers, invoices, invoicesdetail, customers_address_phone, comments , books, publishers, category, categorygroup, publishedbooks, carts cascade;
--install uuid-ossp for using uuid_generate_v4() function.
create extension if not exists "uuid-ossp";

create table admins(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) not null,
	email varchar(50) unique not null,
	password varchar(16) not null,
	role varchar(100),
	isarchived char(1)
);

--1
create table customers(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) unique not null,
	age int,
	email varchar(50) unique not null,
	phone char(10) unique,
	locked char(1),
	password varchar(16) not null,
	createddate date not null,
	updateddate date,
	isarchived char(1)	
);

--2
create table publishers(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) not null,
	description varchar(2000),
	isarchived char(1)
);

--3
create table categorygroup(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) unique not null,
	description varchar(2000),
	createddate date not null,
	updateddate date,
	isarchived char(1)
);

--4
create table customers_address_phone(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	city varchar(20) not null,
	district varchar(20) not null,
	block varchar(20) not null,
	street varchar(20) not null,
	customerid uuid not null,
	isarchived char(1)
);

--5
create table invoices(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	money float8,
	date date,
	states char(1),
	customerid uuid not null,
	isarchived char(1)
);

--6
create table category(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) unique not null,
	description varchar(2000),
	createddate date not null,
	updateddate date,
	groupid uuid not null,
	isarchived char(1)
);

--7
create table books(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	name varchar(100) not null,
	price float8 not null,
	rate int,
	quantity int not null,
	description varchar(2000),
	author varchar(100),
	createddate date not null,
	updateddate date,
	urlimage varchar(100),
	categoryid uuid not null,
	publisherid uuid not null,
	isarchived char(1)
);

--8
create table invoicesdetail(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	quantity int,
	invoiceid uuid,
	bookid uuid,
	isarchived char(1)
);

--9
create table comments(
	id uuid primary key DEFAULT uuid_generate_v4 (),
	rate int,
	comment varchar(2000) not null,
	date date not null,
	customerid uuid not null,
	bookid uuid not null,
	isarchived char(1)
);

--11
create table carts(
	quantity int,
	createddate date,
	customerid uuid,
	bookid uuid,
	primary key(customerid, bookid),
	isarchived char(1)
);

--create foreign key--
alter table customers_address_phone
	add constraint fk_address_phone_customer
	foreign key (customerid)
	references customers(id);

--
alter table invoices 
	add constraint fk_invoice_customer
	foreign key (customerid)
	references customers(id);

--
alter table category 
	add constraint fk_category_categorygoup
	foreign key (groupid)
	references categorygroup(id);

--
alter table books 
	add constraint fk_books_category
	foreign key (categoryid)
	references category(id);
alter table books 
	add constraint fk_books_publishers
	foreign key (publisherid)
	references publishers(id);

--
alter table invoicesdetail
	add constraint fk_invoicesdetail_invoice
	foreign key (invoiceid)
	references invoices(id);
alter table invoicesdetail
	add constraint fk_invoicesdetail_book
	foreign key (bookid)
	references books(id);

--
alter table comments
	add constraint fk_comment_customer
	foreign key (customerid)
	references customers(id);
alter table comments
	add constraint fk_comment_book
	foreign key (bookid)
	references books(id);

--
alter table carts 
	add constraint fk_cart_book
	foreign key (bookid)
	references books(id);
alter table carts 
	add constraint fk_cart_customer
	foreign key (customerid)
	references customers(id);
	

insert into admins(name, email, "password", "role") values('khoa', 'khoa@gmail.com', 'khoa', 'admin');
insert into admins(name, email, "password", "role") values('khuong', 'khuong@gmail.com', 'khuong', 'admin');
insert into admins(name, email, "password", "role") values('hoang', 'hoang@gmail.com', 'khuong', 'admin');

--select * from admins;
insert into admins(id, name, email, "password", "role") values('45b30324-9a61-445b-848b-09aca124723b', 'khoa', 'khoa2@gmail.com', 'khoa', 'admin');
commit;

--customers
insert into customers (id, name, age, email, phone, locked, "password", createddate)
	values('15b30324-9a61-445b-848b-09aca124723b', 'an123', 20, 'an123@gmail.com', '0334487654', null, 'an123', '2021-11-12');
insert into customers (id, name, age, email, phone, locked, "password", createddate)
	values('25b30324-9a61-445b-848b-09aca124723b', 'vuong123', 20, 'vuong123@gmail.com', '0334487655', null, 'vuong123', '2021-11-12');
insert into customers (id, name, age, email, phone, locked, "password", createddate)
	values('35b30324-9a61-445b-848b-09aca124723b', 'thanh123', 20, 'thanh123@gmail.com', '0334487656', null, 'thanh123', '2021-11-12');
insert into customers (id, name, age, email, phone, locked, "password", createddate)
	values('55b30324-9a61-445b-848b-09aca124723b', 'ngoc123', 20, 'ngoc123@gmail.com', '0334487657', null, 'ngoc123', '2021-11-12');

--publishers
insert into publishers (id, name, description)
	values('55b30324-8a61-445b-848b-09aca124723b', 'Kim Đồng',null);
insert into publishers (id, name, description)
	values('55b30324-7a61-445b-848b-09aca124723b', 'Tuổi Trẻ',null);
insert into publishers (id, name, description)
	values('55b30324-6a61-445b-848b-09aca124723b', 'Giáo Dục',null);
insert into publishers (id, name, description)
	values('55b30324-5a61-445b-848b-09aca124723b', 'Đại học quốc gia',null);

--categorygroup
insert into categorygroup (id, name, description, createddate, updateddate)
	values('55b30324-5a61-445b-148b-09aca124723b', 'truyện tranh', 
	'truyện tranh bao gồm nhiều thể loại như Connan, Doraemon, Trạng Quỳnh...', 
	'2021-11-12', null);
insert into categorygroup (id, name, description, createddate, updateddate)
	values('55b30324-5a61-445b-248b-09aca124723b', 'Chính trị và pháp luật', 
	'Chính trị và pháp luật bao gồm nhiều thể loại như Chính trị nước ngoài, trong nước; luật giao thông, luật hanh chính...', 
	'2021-11-12', null);
insert into categorygroup (id, name, description, createddate, updateddate)
	values('55b30324-5a61-445b-348b-09aca124723b', 'Sách giáo trình', 
	'Sách giáo trình bao gồm nhiều thể loại như giáo trình DHQG TP HCM, DHQG HN...', 
	'2021-11-12', null);
insert into categorygroup (id, name, description, createddate, updateddate)
	values('55b30324-5a61-445b-448b-09aca124723b', 'Sách giáo khoa', 
	'Sách giáo khoa bao gồm nhiều thể loại như Lớp 7, Lớp 12...', 
	'2021-11-12', null);

--category
insert into category (id, name, description, createddate, updateddate, groupid)
	values('55b30324-5a61-445b-463a-09aca124723b', 'Connan',null , '2021-11-12', null, '55b30324-5a61-445b-148b-09aca124723b');
insert into category (id, name, description, createddate, updateddate, groupid)
	values('55b30324-5a61-445b-563a-09aca124723b', 'Doraemon',null , '2021-11-12', null, '55b30324-5a61-445b-148b-09aca124723b');
insert into category (id, name, description, createddate, updateddate, groupid)
	values('55b30324-5a61-445b-663a-09aca124723b', 'Lop 7',null , '2021-11-12', null, '55b30324-5a61-445b-448b-09aca124723b');
insert into category (id, name, description, createddate, updateddate, groupid)
	values('55b30324-5a61-445b-763a-09aca124723b', 'Lop 12',null , '2021-11-12', null, '55b30324-5a61-445b-448b-09aca124723b');


--phone and address of customers
insert into customers_address_phone (id, city, district, block, street, customerid)
	values('55b21324-8a61-445b-848b-09aca124723b', 'HCM','Q1', 'Bến Thành', 'số 3 Phạm Ngũ Lão', '15b30324-9a61-445b-848b-09aca124723b');
insert into customers_address_phone (id, city, district, block, street, customerid)
	values('55b22324-8a61-445b-848b-09aca124723b', 'HCM','Q1', 'Bến Nghé', 'số 34 Lê Duẩn', '25b30324-9a61-445b-848b-09aca124723b');	
insert into customers_address_phone (id, city, district, block, street, customerid)
	values('55b23324-8a61-445b-848b-09aca124723b', 'HCM','Q1', 'Phạm Ngũ Lão', 'số 3 Phạm Ngũ Lão', '35b30324-9a61-445b-848b-09aca124723b');	
insert into customers_address_phone (id, city, district, block, street, customerid)
	values('55b24324-8a61-445b-848b-09aca124723b', 'HCM','Q1', 'Phạm Ngũ Lão', 'số 3 Trần Hưng Đạo', '55b30324-9a61-445b-848b-09aca124723b');	

--invoices
insert into invoices (id, money, date, states, customerid)
	values('55b30324-23a3-445b-848b-09aca124723b', null,'2021-11-12', null, '15b30324-9a61-445b-848b-09aca124723b');
insert into invoices (id, money, date, states, customerid)
	values('55b30324-23a4-445b-848b-09aca124723b', null,'2021-11-12', null, '25b30324-9a61-445b-848b-09aca124723b');
insert into invoices (id, money, date, states, customerid)
	values('55b30324-23a5-445b-848b-09aca124723b', null,'2021-11-12', null, '35b30324-9a61-445b-848b-09aca124723b');
insert into invoices (id, money, date, states, customerid)
	values('55b30324-23a6-445b-848b-09aca124723b', null,'2021-11-12', null, '55b30324-9a61-445b-848b-09aca124723b');

--books
insert into books (id, name, price, rate, quantity, description, createddate, updateddate, urlimage, categoryid, publisherid)
	values('55b30324-23a6-445b-11c4-09aca124723b', 'Connan tập 1', 15000, 5, 5, null, '2021-11-12', null, '/image/1', '55b30324-5a61-445b-463a-09aca124723b', '55b30324-8a61-445b-848b-09aca124723b');
insert into books (id, name, price, rate, quantity, description, createddate, updateddate, urlimage, categoryid, publisherid)
	values('55b30324-23a6-445b-21c4-09aca124723b', 'Doraemon tập 1', 20000, 5, 5, null, '2021-11-12', null, '/image/2', '55b30324-5a61-445b-563a-09aca124723b', '55b30324-8a61-445b-848b-09aca124723b');
insert into books (id, name, price, rate, quantity, description, createddate, updateddate, urlimage, categoryid, publisherid)
	values('55b30324-23a6-445b-31c4-09aca124723b', 'Sách Toán 12', 10000, 5, 5, null, '2021-11-12', null, '/image/3', '55b30324-5a61-445b-763a-09aca124723b', '55b30324-6a61-445b-848b-09aca124723b');
insert into books (id, name, price, rate, quantity, description, createddate, updateddate, urlimage, categoryid, publisherid)
	values('55b30324-23a6-445b-41c4-09aca124723b', 'Sách Văn 12', 15000, 5, 5, null, '2021-11-12', null, '/image/4', '55b30324-5a61-445b-763a-09aca124723b', '55b30324-6a61-445b-848b-09aca124723b');

--invoicesdetail
insert into invoicesdetail (id, quantity, invoiceid, bookid)
	values('55b30324-23a6-445b-848b-09aca128323b', 1,'55b30324-23a3-445b-848b-09aca124723b', '55b30324-23a6-445b-11c4-09aca124723b');
insert into invoicesdetail (id, quantity, invoiceid, bookid)
	values('55b30324-23a6-445b-848b-09aca128423b', 1,'55b30324-23a4-445b-848b-09aca124723b', '55b30324-23a6-445b-21c4-09aca124723b');
insert into invoicesdetail (id, quantity, invoiceid, bookid)
	values('55b30324-23a6-445b-848b-09aca128523b', 1,'55b30324-23a5-445b-848b-09aca124723b', '55b30324-23a6-445b-31c4-09aca124723b');
insert into invoicesdetail (id, quantity, invoiceid, bookid)
	values('55b30324-23a6-445b-848b-09aca128623b', 1,'55b30324-23a6-445b-848b-09aca124723b', '55b30324-23a6-445b-41c4-09aca124723b');

--comments
insert into "comments" (id, rate, "comment" , "date" , customerid ,bookid)
	values('55b31924-23a6-445b-848b-09aca128623b', 5,'very good', '2021-11-12', '15b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-11c4-09aca124723b');
insert into "comments" (id, rate, "comment" , "date" , customerid ,bookid)
	values('55b32924-23a6-445b-848b-09aca128623b', 5,'sách oke', '2021-11-12', '15b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-41c4-09aca124723b');
insert into "comments" (id, rate, "comment" , "date" , customerid ,bookid)
	values('55b33924-23a6-445b-848b-09aca128623b', 5,'sách hay', '2021-11-12', '25b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-21c4-09aca124723b');
insert into "comments" (id, rate, "comment" , "date" , customerid ,bookid)
	values('55b34924-23a6-445b-848b-09aca128623b', 5,'sách tốt, 200 sao', '2021-11-12', '55b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-21c4-09aca124723b');


--
insert into carts (quantity, createddate , customerid , bookid)
	values(1,'2021-11-12', '15b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-41c4-09aca124723b');
insert into carts (quantity, createddate , customerid , bookid)
	values(1,'2021-11-12', '15b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-21c4-09aca124723b');
insert into carts (quantity, createddate , customerid , bookid)
	values(1,'2021-11-12', '25b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-41c4-09aca124723b');
insert into carts (quantity, createddate , customerid , bookid)
	values(1,'2021-11-12', '55b30324-9a61-445b-848b-09aca124723b', '55b30324-23a6-445b-41c4-09aca124723b');
commit;

select c."name" , i.id, i2.id , i2.invoiceid, b."name" , p2."name" , c2."name" , c3."name" 
from customers c join invoices i on c.id = i.customerid join invoicesdetail i2 
	on i2.invoiceid =i.id join books b on b.id =i2.bookid join publishers p2 on p2.id = b.publisherid 
	join category c2 on c2.id = b.categoryid join categorygroup c3 on c3.id =c2.groupid ;
