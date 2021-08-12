ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy HH24-MI-SS';
--------------TABLES TESTS ---------------------------
select * from basket;
select * from orders;
select * from storage where STORAGE_PILL_ID BETWEEN 1158 and 1258;
select count(*)from pills;
select * from recipes;
select * from seller;
select * from manager;
select * from pharmacy;
select * from audits;
delete from basket;
delete from orders;
delete from storage;
delete from pills;
delete from recipes;
delete from seller;
delete from manager;
delete from pharmacy;
delete from audits;

-----------------SELLER PACK TESTS---------------------

select seller_pack.check_item_global('PillName_100') from dual;
select seller_pack.check_item_local('Парацетамолл',3) from dual;
select seller_pack.check_category_local('category_2',21) from dual;
select seller_pack.check_category_global('category_1') from dual;
select seller_pack.create_check_getinfo(10)from dual;
select seller_pack.create_check_getorder(10)from dual;
select dev_il.seller_pack.login('Seller_Login_1@farmacy.com',standard_hash('1','SHA512'))from dual;

declare
   result number;
begin
   -- Call the function
   result := seller_pack.create_order(1,1);
   DBMS_OUTPUT.PUT_LINE(result); 
end;
declare
   result number;
begin
   -- Call the function
   result := seller_pack.add_to_basket(10,10,50,1);
   DBMS_OUTPUT.PUT_LINE(result); 
end;

--------------------MANAGER PACK TESTS------------------

declare
   result number;
begin
   -- Call the function
   result := manager_pack.create_seller('Ilya','Kalosha','Valerevich','+375298092169','ilya.kalosha@yandex.com','pass','1');
   DBMS_OUTPUT.PUT_LINE(result); 
end;

declare
   result number;
begin
   -- Call the function
   result := manager_pack.alter_seller(22,NULL,NULL,NULL,'+375298092170',NULL,NULL,NULL);
   DBMS_OUTPUT.PUT_LINE(result); 
end;
select dev_il.manager_pack.get_order_basket(10)from dual;
select manager_pack.get_order_bydate(to_date('20/04/2020'),to_date('22-4-2022'))from dual;

declare
   result number;
begin
   -- Call the function
   result := manager_pack.delete_pill(43);
   DBMS_OUTPUT.PUT_LINE(result); 
end;
declare
   result number;
begin
   -- Call the function
   result := manager_pack.create_pill('name_3', 1,TO_DATE('11/01/2021','dd/mm/yyyy HH24-MI-SS'),TO_DATE('30/01/2021','dd/mm/yyyy HH24-MI-SS'), 'category_3', 'country_3', '2222222', NULL,'PILL_INFO_3');
   DBMS_OUTPUT.PUT_LINE(result); 
end;
declare
   result number;
begin
   -- Call the function
   result := manager_pack.alter_pill(44,NULL, NULL,NULL,NULL,NULL,NULL, '9999', NULL,NULL);
   DBMS_OUTPUT.PUT_LINE(result); 
end;

---------------------------------------------------------

EXECUTE EXPORT_STORAGE_TO_XML;
EXECUTE IMPORT_STORAGE_FROM_XML

---------------------------------------------------------
        SELECT * from pills join storage 
        on pills.pill_id = storage.storage_pill_id 
        where pill_name LIKE('%парацетамолл%');
        
        SELECT * from pills join storage 
        on pills.pill_id = storage.storage_pill_id 
        where CATSEARCH(pill_name, 'парацетамолл',NULL)>0;

select * from pills where pill_name LIKE('%Парацетамол%');
select * from pills where CATSEARCH(pill_name,'Парацетамолл',NULL)>0;

-----------------------------------------------------------
select standard_hash('1','SHA512')from dual;
select manager_pack.get_pharmacy(1) from fual;
select dev_il.manager_pack.get_recipe_doctor('Doctor_1') from fual;


select count(*)from pills;
select * from recipes where recipe_doctor like 'Doctor_1';