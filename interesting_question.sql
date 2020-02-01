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