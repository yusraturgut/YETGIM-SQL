select* from  customers;

--Ülkeye göre müşteri sayısı

select country, count(*) 
from customers group by country;

--İlgili kategoriye göre ürünlerin toplam fiyatları. Toplam fiyatları artan bir şekilde sıralansın.
select
category_id, sum(unit_price) as "Ürün fiyat toplamları"
from products group by category_id order by "Ürün fiyat toplamları"

--Gelişmiş 1. yöntem 
--Kategori id, Kategori Adı, Ürün fiyat toplamları
select 
c.category_name as "Kategori Adı",
sum(p.unit_price) as "Ürün fiyat toplamları" 
from products p 
inner join categories c on p.category_id =c.category_id 
group by "Kategori Adı" order by "Ürün fiyat toplamları" ;


select*from products;
select*from categories;
select*from suppliers;

--suppliers tablosunda ülkeye göre kaç tane supplier var gruplayınız.
SELECT Country, COUNT(*) AS "Toplam Sağlayıcı"
FROM Suppliers
GROUP BY country;

--Gelişmiş 2. yöntem 
--Kategori id, Kategori Adı, Ürün fiyat toplamları
select 
p.category_id,
c.category_name ,
sum(p.unit_price ) as "Ürün fiyat toplamları"
from products p inner join categories c on p.category_id =c.category_id 
group by p.category_id , c.category_name ;

--Kategori başına ortalama, max, min fiyatları gösteren gruplama örneği.
select 
c.category_name as "Kategori adı",
AVG(p.unit_price) as "Ortalama Ürün Fiyatları",
MAX(p.unit_price) as "En Yüksek Fiyat",
MIN(p.unit_price ) as "En Düşük Fiyat",
SUM(p.unit_price ) as "Ürün Fiyatları Toplamı",
COUNT(p.product_id ) as "Ürün sayısı",
SUM(p.units_in_stock ) as "Toplam Stok Miktarı" 
from products p 
inner join categories c on p.category_id=c.category_id group by "Kategori adı" 
order by "Kategori adı"  asc;

SELECT 
    c.category_name AS "Kategori adı",
    ROUND(AVG(p.unit_price)::numeric, 2) AS "Ortalama Ürün Fiyatları",  -- 2 basamaklı yuvarlama
    MAX(p.unit_price) AS "En Yüksek Fiyat",
    MIN(p.unit_price) AS "En Düşük Fiyat",
    SUM(p.unit_price) AS "Ürün Fiyatları Toplamı",
    COUNT(p.product_id) AS "Ürün sayısı",
    SUM(p.units_in_stock) AS "Toplam Stok Miktarı"
FROM products p
INNER JOIN categories c 
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY c.category_name ASC;

select date_part('year',order_date):: int from orders; -->:: İşlemi ordet_date'teki sütunlardaki değerleri int'e dönüştürür

--yıla göre sipariş sayısı
select 
date_part('year',order_date)::varchar as "Yıl",
count(*)as "Sipariş sayısı"
from orders group by "Yıl";

--aya göre sipariş sayısı 
select 
date_part('month',order_date)::varchar as "Ay",
count(*)as "Sipariş sayısı"
from orders group by "Ay";

--Çalışan başına sipariş sayısı 
--Çalışan tam adı, ilk sipariş tarihi, son sipariş tarihi
--1.Yöntem
select
e.first_name as "Çalışan ismi",
e.last_name as "Çalışan soyismi",
COUNT(o.employee_id ) as "Sipariş sayısı",
MIN(o.order_date )as "İlk sipariş tarihi",
MAX(o.order_date ) as "Son Sipariş Tarihi"
from employees e inner join orders o  on o.employee_id=e.employee_id group by "Çalışan ismi" ,"Çalışan soyismi";

--2.Yöntem (isim ve soyisim aynı sütun içinde)
select
    e.first_name || ' ' || e.last_name as "Çalışan Adı Soyadı",
    COUNT(o.employee_id) as "Sipariş sayısı",
    MIN(o.order_date) as "İlk sipariş tarihi",
    MAX(o.order_date) as "Son Sipariş Tarihi"
from employees e
inner join orders o on o.employee_id = e.employee_id
group by e.first_name, e.last_name
order by "Çalışan Adı Soyadı";

--ilgili kategoriye göre ürünlerin toplam fiyatları. Toplam fiyatları artan bir şekilde sıralansın 
--Ürün fiyat toplamları 250'nin üstünde olan datalar
select c.category_name as "Kategori adı",
SUM(p.unit_price) as "Ürün fiyat toplamları"
from products p inner join categories c using(category_id )
group by "Kategori adı" 
having SUM(p.unit_price )>250
order by "Ürün fiyat toplamları"  desc


--Beverages kategorisine ait ürün fiyat toplamlarını getir 
select c.category_name as "Kategori adı",
ROUND(SUM(p.unit_price)) as "Ürün fiyat toplamları"
from products p inner join categories c using(category_id )
group by "Kategori adı" 
having c.category_name ='Beverages'
order by "Ürün fiyat toplamları"  desc

--Toplam stok miktarı alanı 300'den fazla olan dataları listeleyiniz.
select 
c.category_name as "Kategori adı",
ROUND(AVG(p.unit_price)::numeric, 2) as "Ortalama Ürün Fiyatları",  -- 2 basamaklı yuvarlama
MAX(p.unit_price) AS "En Yüksek Fiyat",
MIN(p.unit_price) AS "En Düşük Fiyat",
SUM(p.unit_price) AS "Ürün Fiyatları Toplamı",
COUNT(p.product_id) AS "Ürün sayısı",
SUM(p.units_in_stock) AS "Toplam Stok Miktarı"
from products p
inner join categories c 
on p.category_id = c.category_id
group by  c.category_name
having SUM(p.unit_price) > 300
order by c.category_name asc;

--String Fonksiyonları(Metinsel ifadeler için kullanılacak fonksiyonlar) 
--UPPER(METİN):İlgili metni büyük harfe çevirir.
select 
UPPER(product_name), 
unit_price  
from products;

--LOWER(METİN):İlgili metni küçük harfe çevirir.
select 
LOWER(product_name), 
unit_price  
from products;

--initcap:Kelimelerin ilk harfini büyük yazar.
select  initcap('merhabalar bugün günlerden cuma');

--length:verilen metinsel ifadelerin uzunluğunu verir
select length('Merhabalar benim adım Yüsra');

select length(product_name), product_name  from products;

select*from employees;

--Concat: istenilen sütundaki verileri birleştirir.
select concat(first_name,' ',last_name ) from employees; 

select concat_ws('-',first_name,last_name,title) from employees; 

-- tarih fonksiyonları
select NOW();
select now() as "Şimdiki zaman";
select now() at time zone 'Europe/Rome' as "Roma saati";

-- Şimdi ki zamana 7 gün ekle
select NOW() + interval '7 days'


select now() + interval '1 month' as "1 ay sonraki tarih";


select DATE'2025-10-10'-DATE'2025-8-1'

select (timestamp'2025-10-10 14:53'- TIMESTAMP'2025-9-25 10:25') as "Zaman farkı"


select AGE(TIMESTAMP'2025-10-10','1995-10-10');


select 
extract(year from now())::varchar as "Yıl",
extract(month from now()) as "Ay",
extract(day from now()) as "Gün";

-- KDV HESAPLAYAN FONKSİYON YAZINIZ.
create or replace function  calculate_kdv(price numeric)
returns numeric
language sql
as $$
SELECT price *1.20
$$

select product_name , unit_price , calculate_kdv(unit_price::numeric) as "KDV li birim fiyat" from products;

--2 parametre alan ve bu parametreleri toplayan fonksiyon
create or replace function add_numbers(number1 numeric, number2 numeric)
returns numeric
language sql
as $$
SELECT number1 + number2
$$

select add_numbers(250,951);

-- 2 tane parametre alan ve bu 2 sayıyı çarpan fonksiyonu yazınız.

create or replace function multiply_numbers(number1 numeric, number2 numeric)
returns numeric
language sql
as $$

SELECT number1 * number2
$$

select multiply_numbers(6,5);

--Products tablosundan id'ye göre veri getiren fonksiyon
create or replace function get_products_by_category_id(cid int)
returns setof products
language sql
as $$
SELECT * FROM products where category_id = cid
$$
select * from get_products_by_category_id(3);

-- product_name, category_name, unit_price, units_in_stock, company_name, contact_name
-- p                  c           p              p             s             s
create or replace function get_products_details()
returns TABLE(
product_name products.product_name%type,
category_name categories.category_name%type,
unit_price products.unit_price%type,
units_in_stock products.units_in_stock%type,
company_name suppliers.company_name%type,
contact_name suppliers.contact_name%type
)
language sql 
as $$
select 
p.product_name,
c.category_name ,
p.unit_price ,
p.units_in_stock ,
s.company_name ,
s.contact_name 
from products p  inner join categories c on p.category_id  = c.category_id 
inner join suppliers s  on s.supplier_id = p.supplier_id ; 
$$

select * from get_products_details() where category_name = 'Beverages';


SELECT * FROM get_product_details() WHERE product_name ILIKE 'ch%' ORDER BY product_name LIMIT 3;

select 
c.category_name ,count(p.product_id) as "Ürün sayısı"
from products p
inner join categories c  on c.category_id =p.category_id 
group by c.category_name having count(p.product_id )>5 ;


CREATE OR REPLACE FUNCTION get_group_by_categories_count_gte(miktar NUMERIC) 
RETURNS TABLE(
    category_name categories.category_name%TYPE,
    "Ürün sayısı" NUMERIC
)
LANGUAGE sql 
AS $$
    SELECT 
        c.category_name,
        COUNT(p.product_id) AS "Ürün sayısı"
    FROM products p
    INNER JOIN categories c ON c.category_id = p.category_id
    GROUP BY c.category_name
    HAVING COUNT(p.product_id) > miktar;
$$;

SELECT * FROM get_group_by_categories_count_gte(10);

CREATE OR REPLACE FUNCTION get_price_kdv(p_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    fiyat NUMERIC;
BEGIN
    SELECT unit_price
    INTO fiyat
    FROM products
    WHERE product_id = p_id;

    IF NOT FOUND THEN
        RETURN NULL;
    END IF;

    RETURN fiyat * 1.20;
END;
$$;

select get_price_kdv(1);

select*from products;
