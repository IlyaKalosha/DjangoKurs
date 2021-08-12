CREATE TABLESPACE pharmacyTBS
DATAFILE 'C:\app\ora_install_user\oradata\PHARMACY\TEMP\pharmacyTBS.DAT'
SIZE 50M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 500M;

CREATE TABLE pharmacy
(
    pharmacy_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    pharmacy_city VARCHAR2(50) NOT NULL,
    pharmacy_district VARCHAR2(50) NOT NULL,
    pharmacy_street VARCHAR2(50) NOT NULL,
    pharmacy_index VARCHAR2(50),
    pharmacy_phone VARCHAR2(50),
    CONSTRAINT pharmacy_pk PRIMARY KEY(pharmacy_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE manager
(
    manager_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    manager_name VARCHAR2(50) NOT NULL,
    manager_surname VARCHAR2(50) NOT NULL,
    manager_fathername VARCHAR2(50) NOT NULL,
    manager_phone VARCHAR2(50),
    manager_login varchar2(50) NOT NULL UNIQUE,
    manager_pass varchar2(512) NOT NULL,
    manager_pharmacy_id NUMBER NOT NULL,
    CONSTRAINT manager_pharmacy_fk FOREIGN KEY(manager_pharmacy_id)REFERENCES pharmacy(pharmacy_id),
    CONSTRAINT manager_pk PRIMARY KEY(manager_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE seller
(
    seller_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    seller_name VARCHAR2(50) NOT NULL,
    seller_surname VARCHAR2(50) NOT NULL,
    seller_fathername VARCHAR2(50) NOT NULL,
    seller_phone VARCHAR2(50),
    seller_login varchar2(50) NOT NULL UNIQUE,
    seller_pass varchar2(512) NOT NULL,
    seller_manager_id NUMBER NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY(seller_id),
    CONSTRAINT seller_manager_fk FOREIGN KEY(seller_manager_id)REFERENCES manager(manager_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE recipes
(
    recipe_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    recipe_doctor VARCHAR2(50) NOT NULL,
    recipe_signature VARCHAR2(32) NOT NULL,
    recipe_expiredate DATE NOT NULL,
    CONSTRAINT recipe_pk PRIMARY KEY(recipe_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE pills
(
    pill_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    pill_name VARCHAR2(50) NOT NULL,
    pill_cost NUMBER NOT NULL,
    pill_regdate DATE NOT NULL,
    pill_enddate DATE,
    pill_category VARCHAR2(15),
    pill_country VARCHAR2(20),
    pill_barcode varchar2(30),
    pill_recipe_id NUMBER,
    pill_info varchar2(3000),
    CONSTRAINT pills_recipe_fk FOREIGN KEY(pill_recipe_id)REFERENCES recipes(recipe_id),
    CONSTRAINT pill_pk PRIMARY KEY(pill_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE storage
(
    storage_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    storage_pill_id NUMBER NOT NULL,
    storage_pill_count NUMBER,
    storage_pharmacy_id NUMBER NOT NULL,
    CONSTRAINT storage_pill_fk FOREIGN KEY(storage_pill_id)REFERENCES pills(pill_id),
    CONSTRAINT storage_pharmacy_fk FOREIGN KEY(storage_pharmacy_id)REFERENCES pharmacy(pharmacy_id),
    CONSTRAINT storage_pk PRIMARY KEY(storage_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE orders
(
    order_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
    order_seller_id NUMBER NOT NULL,
    order_pharmacy_id NUMBER NOT NULL,
    order_date DATE,
    CONSTRAINT order_seller_fk FOREIGN KEY(order_seller_id)REFERENCES seller(seller_id),
    CONSTRAINT order_pharmacy_fk FOREIGN KEY(order_pharmacy_id)REFERENCES pharmacy(pharmacy_id),
    CONSTRAINT order_pk PRIMARY KEY(order_id)
) TABLESPACE pharmacyTBS;
CREATE TABLE basket
(
   basket_id NUMBER GENERATED ALWAYS AS IDENTITY(START with 1 INCREMENT by 1),
   basket_order_id NUMBER NOT NULL,
   basket_pill_id NUMBER NOT NULL,
   basket_pill_count NUMBER NOT NULL,
   CONSTRAINT basket_order_fk FOREIGN KEY(basket_order_id)REFERENCES orders(order_id),
   CONSTRAINT basket_pill_fk FOREIGN KEY(basket_pill_id)REFERENCES pills(pill_id),
   CONSTRAINT basket_pk PRIMARY KEY(basket_id)
) TABLESPACE pharmacyTBS;

CREATE TABLE AUDITS(
OperationDate date,
OperationType varchar2(40), 
Table_Name varchar2(40),
Data varchar2(255) 
)TABLESPACE pharmacyTBS;

ALTER TABLE basket ADD CONSTRAINT UNIQUE_BASKET_ITEMS UNIQUE (basket_order_id, basket_pill_id);
ALTER TABLE storage ADD CONSTRAINT UNIQUE_storage_ITEMS UNIQUE (storage_pill_id, storage_pharmacy_id);

CREATE INDEX PILL_INFO_IDX ON PILLS(PILL_INFO) INDEXTYPE IS CTXSYS.CTXCAT;
CREATE INDEX PILL_INFO_IDX ON PILLS(PILL_CATEGORY) INDEXTYPE IS CTXSYS.CTXCAT;
CREATE INDEX PILL_INFO_IDX ON PILLS(PILL_NAME) INDEXTYPE IS CTXSYS.CTXCAT;


drop table basket;
drop table orders;
drop table storage;
drop table pills;
drop table recipes;
drop table seller;
drop table manager;
drop table pharmacy;
drop table audits;