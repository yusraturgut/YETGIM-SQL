select*from products;
select*from customers;
--1)Ürün Aktif mi?
create or replace function nw_is_product_active(p_product_id int)
returns boolean as $$
declare
    v_discontinued boolean;
begin
    select discontinued into v_discontinued
    from products
    where product_id = p_product_id;

    if not found then
        return null;
    end if;

    return not v_discontinued;
end;
$$ language plpgsql;


select nw_is_product_active(25);

--2)Tedarikçi Ürün Sayısı
create or replace function nw_supplier_product_count(p_supplier_id int)
returns int as $$
begin
	return(
		select count(*)
		from products
		where supplier_id=p_supplier_id
	);
end;
$$ language plpgsql;

select nw_supplier_product_count(15);

--3)Müşterinin Yıllık Sipariş Adedi
select*from orders;
create or replace function nw_customer_order_count(p_customer_id text, p_year int)
returns int as $$
begin
    return coalesce(
        (
            select count(*)
            from orders
            where customer_id = p_customer_id
              and extract(year from order_date) = p_year
        ),
        0
    );
end;
$$ language plpgsql;


select nw_customer_order_count('HANAR',1996)

--4)Müşterinin Son Sipariş Tarihi
create or replace function nw_customer_last_order_date(p_customer_id text)
returns date as $$
declare
y_last_date date;
begin
	select max(order_date)
	into y_last_date
	from orders
	where customer_id=p_customer_id;
	
	return y_last_date;
end;
$$ language plpgsql;

select nw_customer_last_order_date('VINET'); -- Beklenen: 1998-05-06 veya örnek tarih

--5)Tek Siparişin Brüt Değeri
select*from order_details;
create or replace function nw_order_gross_value(p_order_id int)
returns numeric(12,2) as $$
declare 
y_total numeric(12,2);
begin
	select sum(unit_price*quantity*(1-discount)),0
	into y_total
	from order_details
	where order_id=p_order_id;
	
	return y_total;
end;
$$ language plpgsql;

select nw_order_gross_value(10248);
select nw_order_gross_value(99999);

--6)Ürünün Tarih Aralığı Geliri
create or replace function nw_product_revenue(
    p_product_id int,
    p_start date DEFAULT '1900-01-01',
    p_end date DEFAULT '9999-12-31'
)
returns numeric(12,2) as $$
declare 
v_revenue numeric(12,2);
begin
	select sum(od.unit_price * od.quantity*(1-od.discount)),0
	into v_revenue
	from order_details od
	inner join orders o on o.order_id=od.order_id
	where od.product_id=p_product_id
	and o.order_date between p_start and p_end;
return v_revenue;
end;
$$ language plpgsql;

select nw_product_revenue(1);
select nw_product_revenue(1, '1997-01-01', '1997-12-31');

--7)Reorder Önerisi
create or replace function nw_reorder_suggestion(p_product_id int)
returns int as $$
declare 
	v_units_in_stock int;
    v_units_on_order int;
    v_reorder_level int;
    v_order_suggestion int;
begin
	select units_in_stock, 
coalesce(units_on_order,0),
reorder_level
	into v_units_in_stock, v_units_on_order, v_reorder_level
	from products
	where product_id=p_product_id;

	if not found then 
	return null;
end if;
if (v_units_in_stock + v_units_on_order)<v_reorder_level then 
v_order_suggestion := v_reorder_level - (v_units_in_stock + v_units_on_order);
else v_order_suggestion:=0;
end if;

return v_order_suggestion;
end;
$$
language plpgsql;

select nw_reorder_suggestion(3);    -- Stok düşükse >0
select nw_reorder_suggestion(2);    -- Stok yeterliyse 0
select nw_reorder_suggestion(9999); -- Geçersiz ürün, NULL döner

--8)Kategori Bazında En Çok Gelir Getiren Ürünler
create or replace function nw_top_products_by_category(
    p_category_id int,
    p_limit int default 5
)
returns table(
product_id int,
product_name text,
revenue numeric(12,2)
)as $$
begin
return query
select 
p.product_id :: int,
p.product_name:: text,
COALESCE(SUM((od.unit_price * od.quantity * (1 - od.discount))::numeric(12,2)), 0.00) AS revenue
from products p
left join order_details od on od.order_id=p.product_id
where p.category_id = p_category_id
group by p.product_id, p.product_name
order by revenue desc
limit p_limit;
end;
$$ language plpgsql;


select*from   nw_top_products_by_category(1);

select*from nw_top_products_by_category(1, 3);

select*from nw_top_products_by_category(9999);

--9)Personel Satış Toplamı (Opsiyonel Tarih)
create or replace function nw_employee_sales_total(
    p_employee_id int,
    p_start date default null,
    p_end date default null
)
returns numeric(12,2) as $$
begin
    return (
        select coalesce(sum((od.unit_price * od.quantity * (1 - od.discount))::numeric(12,2)), 0.00)
        from orders o
        inner join order_details od on od.order_id = o.order_id
        where o.employee_id = p_employee_id
        and (p_start is null or o.order_date >= p_start)
        and (p_end is null or o.order_date <= p_end)
    );
end;
$$ language plpgsql;


select nw_employee_sales_total(1);

select nw_employee_sales_total(1, '1997-01-01', '1997-12-31');

select nw_employee_sales_total(9999); 

--10)Kargocuya Göre Yıllık Siparişler
create or replace function nw_orders_by_shipper(
    p_shipper_id int,
    p_year int
)
returns table(
    order_id int,
    order_date date,
    customer_id text,
    freight numeric(12,2)
) as $$
begin
    return query
    select 
        o.order_id::int,
        o.order_date,
        o.customer_id::text,
        coalesce(o.freight::numeric(12,2), 0.00) as freight
    from orders o
    where o.ship_via = p_shipper_id
      and extract(year from o.order_date) = p_year
    order by o.order_date asc;
end;
$$ language plpgsql;


select * from nw_orders_by_shipper(1, 1997);
select * from nw_orders_by_shipper(2, 1996);
select * from nw_orders_by_shipper(9999, 1997); 



