
/* BEFORE STARTING PLEASE DOWNLOAD THE DATASET FROM https://github.umn.edu/sikka008/BakeryDatabase AND IMPORT USING THE FOLLOWING INSTRUCTIONS:
 * 1. Start your Postgres Environment with a folder mounted (i.e. $ docker run -itv /media/sf_csci4707/dbdemo:/dbdemo postgres bash) where dbdemo is the mounted folder
 * 2. Download the dataset and the SQL files to that mounted folder
 * 3. Simply Run This Script (psql table_setup.sql)
 * 4. Import data using the following commands
 *
 * copy customers from 'dbdemo/BAKERY/customers.csv' delimiter ',' csv header;
 * copy goods from 'dbdemo/BAKERY/goods.csv' delimiter ',' csv header;
 * copy receipts from 'dbdemo/BAKERY/receipts.csv delimiter ',' csv header;
 * copy items from 'dbdemo/BAKERY/items.csv delimiter ',' csv header;
 * 
 * 5. Simply execute the interesting_question.sql script in the current mounted folder (psql interesting_question.sql).
 */


create table if not exists customers (
	Id integer not null,
	LastName varchar(128),
	FirstName varchar(128),
	constraint pk_customer_id primary key (Id)
);



create table if not exists goods (
	Id varchar(128) not null UNIQUE,
	Flavor varchar(128),
	Food varchar(128),
	price varchar(16),
	constraint pk_good_id primary key (id)
);

/*
 * \copy goods 
 * from 'db/BAKERY/goods.csv' delimiter ',' csv header; 
 */



create table if not exists receipts (
	ReceiptNum varchar(16) not null,
	TransactionDate varchar(16),
	CustomerId integer references customers,
	constraint pk_receipt primary key (ReceiptNum)
);

/*
 * \copy receipts
 * from 'db/BAKERY/receipts.csv' delimiter ',' csv header; 
 */

create table if not exists items (
	Receipt varchar(16) not null,
	Ordinal int,
	Item varchar(128) not null references goods,
	constraint fk_receipt foreign key (Receipt) references receipts(ReceiptNum)
);

/*
 * \copy items
 * from 'db/BAKERY/items.csv' delimiter ',' csv header;
 */


/* Interesting question: What are the names of the customers that bought the Napoleon cake? */
with napoleon_cake_id as (
	select id, flavor, food from goods where flavor like '%Napoleon%' and food like '%Cake%'
),
cake_items as (
	select receipt, item, flavor, food from items inner join napoleon_cake_id on (napoleon_cake_id.id = items.item)
),
cake_receipts as (
	select customerid, flavor, food from receipts inner join cake_items on (cake_items.receipt = receipts.receiptnum)
)
select distinct firstname, lastname, flavor, food from customers inner join cake_receipts on (cake_receipts.customerid=customers.id);



