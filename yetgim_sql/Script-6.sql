-- 2tane parametre alan ve bu 2 sayıyı çarpan fonksiyonu yazınız 
create or replace function multiplication(number1 numeric,number2 numeric)
returns numeric 
language sql
as $$ 
select number1*number2 
$$

select multiplication(5, 3);

--products tablosundan belirli bir kategoriye (category_id) ait ürünleri getirir.
create or replace function get_products_by_category_id(cid int)
returns setof products 
language sql 
as $$
select*from products where category_id=cid
$$

select*from get_products_by_category_id(3)

--Ürünlerin detaylı bilgilerini (ürün, kategori ve tedarikçi) bir arada döndürür.
--product_name,category_name, unit_price units_in_stock,company_name,contact_name
create or replace function get_product_details()
returns table(
product_name products.product_name %type,
category_name categories.category_name %type,
unit_price products.unit_price %type,
company_name suppliers.company_name %type,
contact_name suppliers.contact_name %type
) 
language sql
as $$
select 
p.product_name ,
c.category_name ,
p.unit_price ,
s.company_name,
s.contact_name 
from products p inner join categories c  on p.category_id =c.category_id 
inner join suppliers s  on p.supplier_id  =s.supplier_id ;
$$

select*from get_product_details();



