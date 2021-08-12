INSERT INTO pharmacy
(
    pharmacy_city, pharmacy_district, pharmacy_street, pharmacy_index, pharmacy_phone
) 
select  concat('City_', TO_CHAR(level)), concat('District_', TO_CHAR(level)),
concat('Street_', TO_CHAR(level)), concat('Index_', TO_CHAR(level)), concat('phone_', TO_CHAR(level))
from dual connect by level <= 500;  

INSERT INTO recipes
(
    recipe_doctor, recipe_signature, recipe_expiredate
) 
select  concat('Doctor_', TO_CHAR(level)), concat('Signature_', TO_CHAR(level)),
TO_DATE('31/12/2021','dd/mm/yyyy HH24-MI-SS')
from dual connect by level <= 1000;  

INSERT INTO recipes
(
    recipe_doctor, recipe_signature, recipe_expiredate
) 
select  concat('Doctor_', TO_CHAR(1000+level)), concat('Signature_', TO_CHAR(1000+level)),
TO_DATE('31/12/2022','dd/mm/yyyy HH24-MI-SS')
from dual connect by level <= 1000; 

INSERT INTO recipes
(
    recipe_doctor, recipe_signature, recipe_expiredate
) 
select  concat('Doctor_', TO_CHAR(2000+level)), concat('Signature_', TO_CHAR(2000+level)),
TO_DATE('31/12/2023','dd/mm/yyyy HH24-MI-SS')
from dual connect by level <= 1000;

INSERT INTO recipes
(
    recipe_doctor, recipe_signature, recipe_expiredate
) 
select  concat('Doctor_', TO_CHAR(3000+level)), concat('Signature_', TO_CHAR(3000+level)),
TO_DATE('31/12/2024','dd/mm/yyyy HH24-MI-SS')
from dual connect by level <= 2000; 

INSERT INTO manager
(
    manager_name, manager_surname, manager_fathername, manager_phone, manager_login, manager_pass, manager_pharmacy_id
) 
select concat('Manager_Name_', TO_CHAR(level)), concat('Manager_Surname_',TO_CHAR(level)),
concat('Manager_Fathername_', TO_CHAR(level)), concat('Manager_Phone_', TO_CHAR(level)),
concat('Manager_Login_', TO_CHAR(level)), standard_hash(TO_CHAR(level),'SHA512'), level 
from dual connect by level <= 10;

INSERT INTO seller
(
    seller_name, seller_surname, seller_fathername, seller_phone, seller_login, seller_pass, seller_manager_id
) 
select concat('Seller_Name_', TO_CHAR(level)), concat('Seller_Surname_',TO_CHAR(level)),
concat('Seller_Fathername_', TO_CHAR(level)), concat('Seller_Phone_', TO_CHAR(level)),
concat('Seller_Login_', TO_CHAR(level)), standard_hash(TO_CHAR(level),'SHA512'), level 
from dual connect by level <= 10;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(level)), level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2021','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '1'), concat('Country_', '1'), TO_CHAR(level), level, concat('Pill_info_', TO_CHAR(level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(5000+level)), 5000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2021','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '2'), concat('Country_', '2'), TO_CHAR(5000+level), NULL, concat('Pill_info_', TO_CHAR(5000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(10000+level)), 10000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2022','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '3'), concat('Country_', '3'), TO_CHAR(10000+level), NULL, concat('Pill_info_', TO_CHAR(10000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(15000+level)), 15000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2022','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '4'), concat('Country_', '4'), TO_CHAR(15000+level), NULL, concat('Pill_info_', TO_CHAR(15000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(20000+level)), 20000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2023','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '5'), concat('Country_', '5'), TO_CHAR(20000+level), NULL, concat('Pill_info_', TO_CHAR(20000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(25000+level)), level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2023','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '6'), concat('Country_', '6'), TO_CHAR(level), NULL, concat('Pill_info_', TO_CHAR(25000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(30000+level)), 30000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2024','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '7'), concat('Country_', '7'), TO_CHAR(30000+level), NULL, concat('Pill_info_', TO_CHAR(30000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(35000+level)), 35000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2024','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '8'), concat('Country_', '8'), TO_CHAR(35000+level), NULL, concat('Pill_info_', TO_CHAR(35000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(40000+level)), 40000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2025','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '9'), concat('Country_', '9'), TO_CHAR(40000+level), NULL, concat('Pill_info_', TO_CHAR(40000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(45000+level)), 45000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2025','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '10'), concat('Country_', '10'), TO_CHAR(45000+level), NULL, concat('Pill_info_', TO_CHAR(45000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(50000+level)), 50000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2026','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '11'), concat('Country_', '11'), TO_CHAR(50000+level), NULL, concat('Pill_info_', TO_CHAR(50000+level))
from dual connect by level <= 5000;
---unique
INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)VALUES
('Парацетамолл',12345,TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'),TO_DATE('27/11/2021','dd/mm/yyyy HH24-MI-SS'),
'Жаропонижающее','Беларусь','111333',NULL,
'анальгетик и антипиретик (обезболивающее и жаропонижающее средство). Блокирует циклооксигеназу в центральной нервной системе, воздействуя на центры боли и терморегуляции. Противовоспалительный эффект практически отсутствует.');

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(55001+level)), 55001+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2026','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '12'), concat('Country_', '12'), TO_CHAR(55001+level), NULL, concat('Pill_info_', TO_CHAR(55001+level))
from dual connect by level <= 4999;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(60000+level)), 60000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2027','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '13'), concat('Country_', '13'), TO_CHAR(60000+level), NULL, concat('Pill_info_', TO_CHAR(60000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(65000+level)), 65000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2027','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '14'), concat('Country_', '14'), TO_CHAR(65000+level), NULL, concat('Pill_info_', TO_CHAR(65000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(70000+level)), 70000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2028','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '15'), concat('Country_', '15'), TO_CHAR(70000+level), NULL, concat('Pill_info_', TO_CHAR(70000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(75000+level)), 75000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2029','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '16'), concat('Country_', '16'), TO_CHAR(75000+level), NULL, concat('Pill_info_', TO_CHAR(75000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(80000+level)), 80000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2030','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '17'), concat('Country_', '17'), TO_CHAR(80000+level), NULL, concat('Pill_info_', TO_CHAR(80000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(85000+level)), 85000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2030','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '18'), concat('Country_', '18'), TO_CHAR(85000+level), NULL, concat('Pill_info_', TO_CHAR(85000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(90000+level)), 90000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('30/06/2031','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '19'), concat('Country_', '19'), TO_CHAR(90000+level), NULL, concat('Pill_info_', TO_CHAR(90000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(95000+level)), 95000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2031','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '20'), concat('Country_', '20'), TO_CHAR(95000+level), NULL, concat('Pill_info_', TO_CHAR(95000+level))
from dual connect by level <= 5000;

INSERT INTO pills
(
    pill_name, pill_cost, pill_regdate, pill_enddate, pill_category, pill_country, pill_barcode, pill_recipe_id, pill_info
)
select  concat('PillName_', TO_CHAR(100000+level)), 100000+level, TO_DATE(sysdate,'dd/mm/yyyy HH24-MI-SS'), TO_DATE('31/12/2032','dd/mm/yyyy HH24-MI-SS'),
concat('Category_', '21'), concat('Country_', '21'), TO_CHAR(100000+level), NULL, concat('Pill_info_', TO_CHAR(100000+level))
from dual connect by level <= 100000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select level, 100, 1
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 20000+level, 100, 2
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 40000+level, 100, 3
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 60000+level, 100, 4
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 80000+level, 100, 5
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 100000+level, 100, 6
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 120000+level, 100, 7
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 140000+level, 100, 8
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 160000+level, 100, 9
from dual connect by level<=20000;

INSERT INTO storage
(
    STORAGE_PILL_ID, storage_pill_count, storage_pharmacy_id
)
select 180000+level, 100, 10
from dual connect by level<=20000;

INSERT INTO orders
(
    order_seller_id, order_pharmacy_id, order_date
)
SELECT level, level, TO_DATE(sysdate,'yyyy/mm/dd HH24-MI-SS')
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 1, level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 2, 10+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 3, 20+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 4, 30+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 5, 30+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 6, 40+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 7, 50+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 8, 60+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 9, 70+level, 10 
from dual connect by level <=10;

INSERT INTO basket
(
    basket_order_id, basket_pill_id, basket_pill_count
)
SELECT 10, 80+level, 10 
from dual connect by level <=10;



update manager set manager.manager_login = concat(manager.manager_login,'@farmacy.com');
update seller set seller.seller_login = concat(seller.seller_login,'@farmacy.com');

