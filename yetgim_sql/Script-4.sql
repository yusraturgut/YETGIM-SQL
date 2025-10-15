select * from products;
select * from suppliers;
select * from categories;

select
p.product_name as "Ürün adı",
p.unit_price as "Ürün Fiyatı",
c.category_name  as "Kategori adı",
s.company_name  as "Şirket adı",
s.address as "Şirket Adresi"
from products p 
inner join categories c  on c.category_id =p.category_id 
inner join suppliers s on s.supplier_id =p.supplier_id 

--Aggregate fonksiyon
--AVG, SUM, MIN, MAX, COUNT

select 
AVG(unit_price) as "Ürünlerin fiyat ortalaması",
SUM(units_in_stock) as "Toplam ürün adedi",
MIN(unit_price) as "En Düşük Fiyat",
MAX(unit_price) as "En yüksek Fiyat",
count(*) as "Tablodaki ürün sayısı",
SUM(unit_price*units_in_stock) as "Ürünler satıldığında kasaya girem para"
from products ;

