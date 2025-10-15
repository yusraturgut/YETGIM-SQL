create table categories(
category_id SERIAL primary key,
name varchar(50)not null,
description varchar(250)
);

CREATE TABLE products(
products_id BIGSERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
price NUMERIC(10,2) NOT NULL CHECK (price >=0),
stock INT NOT NULL CHECK (stock>=0),
category_id INT NOT NULL,
CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO categories (name, description) VALUES
('Elektronik', 'Elektronik cihazlar ve aksesuarlar'),
('Kitap', 'Her türlü kitap ve romanlar'),
('Giyim', 'Erkek ve kadın giyim ürünleri'),
('Ev & Mutfak', 'Mobilya, mutfak eşyaları ve ev gereçleri'),
('Oyuncak', 'Çocuklar için oyuncak ve oyunlar'),
('Spor', 'Spor ekipmanları ve aksesuarları'),
('Güzellik', 'Kozmetik ve kişisel bakım ürünleri');



INSERT INTO products (name, price, stock, category_id) VALUES
('Akıllı Telefon', 4999.99, 50, 1),
('Dizüstü Bilgisayar', 8999.50, 30, 1),
('Roman Kitap', 45.00, 120, 2),
('T-Shirt', 75.99, 200, 3),
('Mikser', 350.50, 40, 4),
('Aksiyon Figürü', 150.00, 80, 5),
('Futbol Topu', 120.00, 60, 6),
('Ruj', 99.99, 150, 7);



INSERT INTO products(name, price, stock, category_id) VALUES
('Msi Bravo 15', 35000, 140, 1),
('Asus ROG Strix G15', 42000, 85, 1),
('Lenovo ThinkPad E14', 28000, 120, 1),
('HP Pavilion 15', 25000, 95, 1),
('Dell XPS 13', 55000, 45, 1),
('Acer Aspire 5', 22000, 150, 1);

-- Telefon Kategorisi Ürünleri (category_id: 2)
INSERT INTO products(name, price, stock, category_id) VALUES
('iPhone 15 Pro', 65000, 75, 2),
('Samsung Galaxy S24', 48000, 110, 2),
('Xiaomi Redmi Note 13', 12000, 200, 2),
('Oppo Reno 11', 18000, 135, 2),
('Google Pixel 8', 42000, 60, 2),
('Huawei P60', 35000, 80, 2);

-- Kozmetik Kategorisi Ürünleri (category_id: 3)
INSERT INTO products(name, price, stock, category_id) VALUES
('Maybelline Fit Me Fondöten', 350, 250, 3),
('L''Oreal Paris Rimel', 280, 300, 3),
('Nivea Nemlendirici Krem', 165, 400, 3),
('Garnier Güneş Kremi SPF50', 220, 350, 3),
('Flormar Ruj', 125, 500, 3),
('The Ordinary Serum', 450, 180, 3);

-- Atıştırmalık Kategorisi Ürünleri (category_id: 4)
INSERT INTO products(name, price, stock, category_id) VALUES
('Ülker Çikolatalı Gofret', 35, 600, 4),
('Doritos Nacho Peynirli', 45, 450, 4),
('Eti Burçak Bisküvi', 28, 700, 4),
('Tadım Antep Fıstığı 150g', 180, 200, 4),
('Pringles Süper Peynirli', 65, 350, 4),
('Ülker Halley Bisküvi', 42, 550, 4);

-- Süt ve Süt Ürünleri Kategorisi (category_id: 5)
INSERT INTO products(name, price, stock, category_id) VALUES
('Pınar Süt 1L', 45, 800, 5),
('Sütaş Beyaz Peynir 500g', 125, 400, 5),
('Danone Süzme Yoğurt', 38, 600, 5),
('Président Kaşar Peyniri 350g', 185, 300, 5),
('Sek Süt 1L', 42, 750, 5),
('Eker Krem Peynir', 95, 450, 5);

-- Ev Aletleri Kategorisi (category_id: 6)
INSERT INTO products(name, price, stock, category_id) VALUES
('Arçelik K 1281 Kettle', 1250, 120, 6),
('Tefal Filtre Kahve Makinesi', 2800, 85, 6),
('Sinbo Blender Set', 950, 150, 6),
('Philips Ütü 2400W', 1650, 110, 6),
('Bosch MUM Serie Mikser', 4500, 65, 6),
('Fakir Kaave Türk Kahve Mak.', 2200, 95, 6);

-- Giyim Kategorisi Ürünleri (category_id: 7)
INSERT INTO products(name, price, stock, category_id) VALUES
('Levi''s 501 Original Jean', 1850, 180, 7),
('Nike Air Max Tişört', 650, 250, 7),
('Adidas Sweatshirt', 1200, 200, 7),
('Mavi Regular Fit Gömlek', 850, 220, 7),
('Koton Kadın Elbise', 750, 300, 7),
('LC Waikiki Erkek Pantolon', 550, 350, 7);

select*from categories;
select*from products;

insert into categories(name) values('Tablet'),('Monitor'),('Klavye');

--urun_adi, urun_kategorisi, urun_fıyatı, urun_stok
-- P           C              p           c

--INNER JOIN
select products."name" as urun_adı,
categories."name" as urun_kategori_adi,
products.price as urun_fiyatı,
products.stock as urun_stok 
from products 
inner join  categories on products.category_id =categories.category_id 







