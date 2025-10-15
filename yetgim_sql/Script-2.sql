select*from categories;
select*from products;

--inner join->Sadece iki tabloda da ortak olan kayıtları getir. as takısı kolona takma ad vermemizi sağlar
select products."name" as "ürün adı",
products.price as "ürün fiyatı",
products.stock as "ürün stok",
categories."name" as "ürün kategori ",
categories.description as "kategori açıklaması"
from products
inner join categories on products.category_id = categories.category_id 

select 
products.name,
products.price,
products.stock,
categories.name,
categories.description
from products 
inner join categories on products.category_id =categories.category_id;

select 
p.name,
p.price,
p.stock,
c.name,
c.description
from products p
inner join categories c on p.category_id =c.category_id; -->p ve c ile tablo adlarını kısaltmış olduk.

--Ürün adı, Ürün fiyatı,Ürün Stok Adedi,Kategori adı
--Fiyati 25000'den fazla olan verileri gösteriniz

select 
p."name" as "ürün adı",
p.price as "ürün fiyatı",
p.stock as "ürün stok",
c."name" as "ürün kategori "
from products p
inner join categories c on p.category_id =c.category_id
where p.price>25000;

--Ürün adı, Ürün fiyatı,Ürün Stok Adedi,Kategori adı
--Kategorisi bilgisayar olan ve en pahalı 3 ürünü listeleyiniz.

select * from products limit 3;-- sadeece ilk 3 satırı getir

select 
p."name" as "ürün adı",
p.price as "ürün fiyatı",
p.stock as "ürün stok",
c."name" as "ürün kategori "
from products p
inner join categories c on p.category_id =c.category_id
where 
c."name"='Elektronik' order by p.price desc limit 3

insert into products("name",
price, 
stock) values ('kategorisiz ürün 1',254,360),('kategorisiz ürün 1',154,160);

select 
p."name" as "ürün adı",
p.price as "ürün fiyatı",
p.stock as "ürün stok",
c."name" as "ürün kategori "
from products p
right join categories c on p.category_id =c.category_id 

select 
p."name" as "ürün adı",
p.price as "ürün fiyatı",
p.stock as "ürün stok",
c."name" as "ürün kategori "
from products p
left join categories c on p.category_id =c.category_id -->ürünlerin hepsi yani sol taraftaki veriler gelmek zorunda sağdakiler boş olsa da olur 

select 
p."name" as "ürün adı",
p.price as "ürün fiyatı",
p.stock as "ürün stok",
c."name" as "ürün kategori "
from products p
full join categories c on p.category_id =c.category_id 

select 
coalesce (c."name",'Kategori bulunamadı.') as "kategori adı",-->calesce: null değer dönüyorsa o satıra istediğini yazdır.
coalesce(p."name",'Ürün adı bulunamadı.') as "ürün adı",
coalesce(p.price,0) as "ürün fiyatı"--> numeric değere metinsel ifade veremezsin.
from products p full join categories c  on p.category_id =c.category_id 


create table products_details(
product_id bigint primary key
references products(product_id),
barcode varchar(50) unique,
color varchar(50),
size varchar(50)
);

insert into products_details (
product_id,
barcode,
color,
"size") values (3,'msbr2','Black','kg')

select 
p."name" ,
pd.barcode,
pd.color 
from products p inner join products_details pd using(product_id)


select*from products_details

create table suppliers(
supplier_id serial primary key,
name varchar(50) not null,
adress varchar(200),
prhone varchar(25)
);


create table product_supliers(
id serial primary key,
pruduct_id BIGINT not null references products(product_id),
suplier_id BIGINT not null references suppliers(supplier_id)
)

INSERT INTO suppliers (name, adress, prhone)
VALUES
  ('ABC Ticaret Ltd.', 'İstiklal Caddesi No: 10, Beyoğlu, İstanbul', '+90 212 555 0101'),
  ('XYZ İthalat A.Ş.',     'Atatürk Bulvarı No: 45, Kadıköy, İstanbul', '+90 216 444 0202');


select* from suppliers ;

insert into product_suppliers (product_id,supplier_id) values (1,1),(3,1),(4,1),(10,1);
insert into product_suppliers (product_id,supplier_id) values (8,2),(11,2),(25,2),(33,2),(48,3),(3,3),(7,3),(25,3);


SELECT 
    p.name AS "Ürün Adı",
    p.price AS "Ürün fiyatı",
    s.name AS "Sağlayıcı adı",
    s.prhone AS "Sağlayıcı telefonu",
    c.name AS "Kategori adı"
FROM product_suppliers ps
INNER JOIN products p ON p.product_id = ps.product_id
INNER JOIN suppliers s ON s.supplier_id = ps.supplier_id
INNER JOIN categories c ON p.category_id = c.category_id;




