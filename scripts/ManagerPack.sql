CREATE OR REPLACE PACKAGE manager_pack AS
     
    FUNCTION create_seller
    (
        seller_name VARCHAR2,
        seller_surname VARCHAR2,
        seller_fathername VARCHAR2,
        seller_phone VARCHAR2,
        seller_login varchar2,
        seller_pass varchar2,
        seller_manager_id NUMBER
    ) RETURN NUMBER;
    
    FUNCTION alter_seller
    (
        seller_toupdate_id NUMBER,
        c_seller_name VARCHAR2,
        c_seller_surname VARCHAR2,
        c_seller_fathername VARCHAR2,
        c_seller_phone VARCHAR2,
        c_seller_login varchar2,
        c_seller_pass varchar2
    )return NUMBER;
    
    FUNCTION delete_seller
    (
        c_seller_id NUMBER
    ) RETURN NUMBER;
        
    FUNCTION get_pharmacy
    ( 
        c_pharmacy_id NUMBER
    ) return SYS_REFCURSOR;
    
    FUNCTION get_celler
    ( 
        c_manager_id NUMBER
    ) return SYS_REFCURSOR;
    
    FUNCTION alter_pharmacy
    (
        c_pharmacy_id NUMBER,
        c_pharmacy_city VARCHAR2,
        c_pharmacy_distr VARCHAR2,
        c_pharmacy_street VARCHAR2,
        c_pharmacy_index VARCHAR2,
        c_pharmacy_phone VARCHAR2
    )return NUMBER;
    
    FUNCTION login
    (
        user_login manager.manager_login%TYPE,
        user_pass manager.manager_pass%TYPE
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION get_order_basket
    (
        order_id NUMBER
    ) return SYS_REFCURSOR;
    
    FUNCTION get_order_bydate
    (
        start_date DATE,
        end_date DATE
    ) return SYS_REFCURSOR;
    
    FUNCTION get_pill_name
    (
        c_name VARCHAR2    
    )RETURN SYS_REFCURSOR;
    
    FUNCTION get_pill_category
    (
        c_category VARCHAR2    
    )RETURN SYS_REFCURSOR;
    
    FUNCTION get_pill_cost
    (
         c_start_cost NUMBER,    
        c_end_cost NUMBER    
    )RETURN SYS_REFCURSOR;
    
    FUNCTION get_pill_date
    (
        c_expdate DATE    
    )RETURN SYS_REFCURSOR;
    
    FUNCTION create_pill
    (
        c_pill_name VARCHAR2,
        c_pill_cost NUMBER,
        c_pill_regdate DATE,
        c_pill_enddate DATE,
        c_pill_category VARCHAR2,
        c_pill_country VARCHAR2,
        c_pill_barcode varchar2,
        c_pill_recipe_id NUMBER,
        c_pill_info VARCHAR2
    )RETURN NUMBER;
    
    FUNCTION alter_pill
    (
        pill_toupdate_id NUMBER,
        c_pill_name VARCHAR2,
        c_pill_cost NUMBER,
        c_pill_regdate DATE,
        c_pill_enddate DATE,
        c_pill_category VARCHAR2,
        c_pill_country VARCHAR2,
        c_pill_barcode varchar2,
        c_pill_recipe_id NUMBER,
        c_pill_info VARCHAR2
    )RETURN NUMBER;
    
    FUNCTION delete_pill
    (
        c_pill_id NUMBER
    ) RETURN NUMBER;
    
    FUNCTION get_storage
    (
        c_id NUMBER,
        c_pharmacy_id NUMBER
    )return SYS_REFCURSOR;  
    
    FUNCTION create_storage
    (
        c_pill_id NUMBER,
        c_pill_count NUMBER,
        c_pharmacy_id NUMBER
    )RETURN NUMBER;
    
    FUNCTION alter_storage
    (
        storage_toupdate_id NUMBER,
        c_pill_id NUMBER,
        c_pill_count NUMBER,
        c_pharmacy_id NUMBER
    )RETURN NUMBER;
    
    FUNCTION delete_storage
    (
        c_storage_id NUMBER 
    )RETURN NUMBER;
    
    FUNCTION get_recipe_doctor
    ( 
        c_doctor_name VARCHAR2
    ) return SYS_REFCURSOR;
    
    FUNCTION get_recipe_date
    ( 
        c_expite_date DATE
    ) return SYS_REFCURSOR;
    
    FUNCTION create_recipe
    (
        c_doctor VARCHAR2,
        c_signature VARCHAR2,
        c_expiredate DATE
    )RETURN NUMBER;
    
    FUNCTION alter_recipe
    (
        recipe_toupdate_id NUMBER,
        c_doctor VARCHAR2,
        c_signature VARCHAR2,
        c_expiredate DATE
    )RETURN NUMBER;
    
    FUNCTION delete_recipe
    (
        c_recipe_id NUMBER 
    )RETURN NUMBER;
    
END manager_pack;


CREATE OR REPLACE PACKAGE BODY manager_pack AS

    FUNCTION delete_seller
    (
        c_seller_id NUMBER
    ) RETURN NUMBER AS
    deleted_seller NUMBER;
    BEGIN
        delete from seller where seller_id=c_seller_id returning seller_id into deleted_seller;
        COMMIT;
    RETURN deleted_seller;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;

    FUNCTION create_seller
    (
        seller_name VARCHAR2,
        seller_surname VARCHAR2,
        seller_fathername VARCHAR2,
        seller_phone VARCHAR2,
        seller_login varchar2,
        seller_pass varchar2,
        seller_manager_id NUMBER
    ) RETURN NUMBER AS
    created_user NUMBER;
    BEGIN
        INSERT INTO seller(seller_name, seller_surname, seller_fathername, seller_phone, seller_login, seller_pass, seller_manager_id) VALUES
        (
            seller_name,
            seller_surname,
            seller_fathername,
            seller_phone,
            seller_login,
            seller_pass,
            seller_manager_id
        ) returning seller_id into created_user;
        COMMIT;
        RETURN created_user;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION alter_seller
    (
        seller_toupdate_id NUMBER,
        c_seller_name VARCHAR2,
        c_seller_surname VARCHAR2,
        c_seller_fathername VARCHAR2,
        c_seller_phone VARCHAR2,
        c_seller_login VARCHAR2,
        c_seller_pass VARCHAR2
        )return NUMBER AS
    BEGIN
        IF c_seller_name is NOT NULL THEN
            UPDATE seller set seller.seller_name = c_seller_name where seller.seller_id=seller_toupdate_id;
        END IF;    
        IF c_seller_surname is NOT NULL THEN
            UPDATE seller set seller.seller_surname = c_seller_surname where seller.seller_id=seller_toupdate_id;
        END IF;  
        IF c_seller_fathername is NOT NULL THEN
            UPDATE seller set seller.seller_fathername = c_seller_fathername where seller.seller_id=seller_toupdate_id;
        END IF;  
        IF c_seller_phone is NOT NULL THEN
            UPDATE seller set seller.seller_phone = c_seller_phone where seller.seller_id=seller_toupdate_id;
        END IF;  
        IF c_seller_login is NOT NULL THEN
            UPDATE seller set seller.seller_login = c_seller_login where seller.seller_id=seller_toupdate_id;
        END IF;  
        IF c_seller_pass is NOT NULL THEN
            UPDATE seller set seller.seller_pass = c_seller_pass where seller.seller_id=seller_toupdate_id;
        END IF;  
        COMMIT;
        RETURN seller_toupdate_id;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION alter_pharmacy
    (
        c_pharmacy_id NUMBER,
        c_pharmacy_city VARCHAR2,
        c_pharmacy_distr VARCHAR2,
        c_pharmacy_street VARCHAR2,
        c_pharmacy_index VARCHAR2,
        c_pharmacy_phone VARCHAR2
    )return NUMBER AS
    BEGIN
        IF c_pharmacy_city is NOT NULL THEN
            UPDATE pharmacy set pharmacy_city = c_pharmacy_city where pharmacy_id=c_pharmacy_id;
        END IF;    
        IF c_pharmacy_distr is NOT NULL THEN
            UPDATE pharmacy set pharmacy_district = c_pharmacy_distr where pharmacy_id=c_pharmacy_id;
        END IF;    
        IF c_pharmacy_street is NOT NULL THEN
            UPDATE pharmacy set pharmacy_street = c_pharmacy_street where pharmacy_id=c_pharmacy_id;
        END IF;    
        IF c_pharmacy_index is NOT NULL THEN
            UPDATE pharmacy set pharmacy_index = c_pharmacy_index where pharmacy_id=c_pharmacy_id;
        END IF;    
        IF c_pharmacy_phone is NOT NULL THEN
            UPDATE pharmacy set pharmacy_phone = c_pharmacy_phone where pharmacy_id=c_pharmacy_id;
        END IF;    
        RETURN c_pharmacy_id;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_pharmacy
    (
        c_pharmacy_id NUMBER
    )RETURN SYS_REFCURSOR as
    c_pharmacy SYS_REFCURSOR;
    BEGIN
    OPEN c_pharmacy FOR
        select * from pharmacy where pharmacy.pharmacy_id=c_pharmacy_id;
        RETURN c_pharmacy;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_celler
    ( 
        c_manager_id NUMBER
    ) RETURN SYS_REFCURSOR as
    c_seller SYS_REFCURSOR;
    BEGIN
    OPEN c_seller FOR
        select * from seller where seller_manager_id=c_manager_id;
        RETURN c_seller;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION login
    (
        user_login manager.manager_login%TYPE,
        user_pass manager.manager_pass%TYPE
    ) RETURN SYS_REFCURSOR as
    c_user SYS_REFCURSOR;
    BEGIN
    OPEN c_user FOR
        select * from manager where manager.manager_login = user_login and manager.manager_pass = user_pass ;
        RETURN c_user;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_order_basket
    (
        order_id NUMBER
    ) RETURN SYS_REFCURSOR as
    c_order SYS_REFCURSOR;
    BEGIN
    OPEN c_order FOR
        select * from basket where basket_order_id = order_id;
        RETURN c_order;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_order_bydate
    (
        start_date DATE,
        end_date DATE
    ) RETURN SYS_REFCURSOR as
    c_orders SYS_REFCURSOR;
    BEGIN
    OPEN c_orders FOR
        select * from orders where orders.order_date BETWEEN start_date and end_date;
        RETURN c_orders;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_pill_name
    (
        c_name VARCHAR2    
    )RETURN SYS_REFCURSOR as
    c_pill SYS_REFCURSOR;
    BEGIN
    OPEN c_pill FOR
        select * from pills where CATSEARCH(pill_name, c_name, NULL)>0;
        RETURN c_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_pill_category
    (
        c_category VARCHAR2    
    )RETURN SYS_REFCURSOR as
    c_pill SYS_REFCURSOR;
    BEGIN
    OPEN c_pill FOR
        select * from pills where CATSEARCH(pill_category, c_category, NULL)>0;
        RETURN c_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_pill_cost
    (
        c_start_cost NUMBER,    
        c_end_cost NUMBER
    )RETURN SYS_REFCURSOR as
    c_pill SYS_REFCURSOR;
    BEGIN
    OPEN c_pill FOR
        select * from pills where pills.pill_cost BETWEEN c_start_cost and c_end_cost;
        RETURN c_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_pill_date
    (
        c_expdate DATE    
    )RETURN SYS_REFCURSOR as
    c_pill SYS_REFCURSOR;
    BEGIN
    OPEN c_pill FOR
        select * from pills where pill_enddate<c_expdate;
        RETURN c_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION delete_pill
    (
        c_pill_id NUMBER
    ) RETURN NUMBER AS
    deleted_pill NUMBER;
    BEGIN
        delete from pills where pill_id=c_pill_id returning pill_id into deleted_pill;
    RETURN deleted_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION create_pill
    (
        c_pill_name VARCHAR2,
        c_pill_cost NUMBER,
        c_pill_regdate DATE,
        c_pill_enddate DATE,
        c_pill_category VARCHAR2,
        c_pill_country VARCHAR2,
        c_pill_barcode varchar2,
        c_pill_recipe_id NUMBER,
        c_pill_info VARCHAR2
    )RETURN NUMBER AS
    created_pill NUMBER;
    BEGIN
        INSERT INTO pills(pill_name,pill_cost,pill_regdate,pill_enddate,pill_category,pill_country,pill_barcode,pill_recipe_id,pill_info)
        values(c_pill_name,c_pill_cost,c_pill_regdate,c_pill_enddate,c_pill_category,c_pill_country,c_pill_barcode,c_pill_recipe_id,c_pill_info)returning pill_id into created_pill;
        return created_pill;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION alter_pill
    (
        pill_toupdate_id NUMBER,
        c_pill_name VARCHAR2,
        c_pill_cost NUMBER,
        c_pill_regdate DATE,
        c_pill_enddate DATE,
        c_pill_category VARCHAR2,
        c_pill_country VARCHAR2,
        c_pill_barcode varchar2,
        c_pill_recipe_id NUMBER,
        c_pill_info VARCHAR2
    )RETURN NUMBER AS
    BEGIN
        IF c_pill_name is NOT NULL THEN
            UPDATE pills set pill_name = c_pill_name where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_cost is NOT NULL THEN
            UPDATE pills set pill_cost = c_pill_cost where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_regdate is NOT NULL THEN
            UPDATE pills set pill_regdate = c_pill_regdate where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_enddate is NOT NULL THEN
            UPDATE pills set pill_enddate = c_pill_enddate where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_category is NOT NULL THEN
            UPDATE pills set pill_category = c_pill_category where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_country is NOT NULL THEN
            UPDATE pills set pill_country = c_pill_country where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_barcode is NOT NULL THEN
            UPDATE pills set pill_barcode = c_pill_barcode where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_info is NOT NULL THEN
            UPDATE pills set pill_info  = c_pill_info  where pill_id=pill_toupdate_id;
        END IF; 
        IF c_pill_barcode is NOT NULL THEN
            UPDATE pills set pill_barcode  = c_pill_barcode  where pill_id=pill_toupdate_id;
        END IF; 
        RETURN pill_toupdate_id;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
        
    FUNCTION get_storage
    (
        c_id NUMBER,
        c_pharmacy_id NUMBER
    )return SYS_REFCURSOR AS
    c_storage SYS_REFCURSOR;
    BEGIN
    OPEN c_storage FOR
        select * from storage where storage_pill_id=c_id and storage_pharmacy_id=c_pharmacy_id;
        RETURN c_storage;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
        
    FUNCTION create_storage
    (
        c_pill_id NUMBER,
        c_pill_count NUMBER,
        c_pharmacy_id NUMBER
    )RETURN NUMBER AS
    created_storage NUMBER;
    BEGIN
        INSERT INTO storage(storage_pill_id,storage_pill_count,storage_pharmacy_id)
        values(c_pill_id, c_pill_count, c_pharmacy_id)returning storage_id into created_storage;
        return created_storage;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION alter_storage
    (
        storage_toupdate_id NUMBER,
        c_pill_id NUMBER,
        c_pill_count NUMBER,
        c_pharmacy_id NUMBER
    )RETURN NUMBER AS
    BEGIN
        IF c_pill_id is NOT NULL THEN
            UPDATE storage set storage_pill_id = c_pill_id where storage_id=storage_toupdate_id and storage_pharmacy_id=c_pharmacy_id;
        END IF;
        IF c_pill_count is NOT NULL THEN
            UPDATE storage set storage_pill_count = c_pill_count where storage_id=storage_toupdate_id and storage_pharmacy_id=c_pharmacy_id;
        END IF;
        RETURN storage_toupdate_id;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION delete_storage
    (
        c_storage_id NUMBER 
    )RETURN NUMBER AS
    deleted_storage NUMBER;
    BEGIN
        delete from storage where storage_id=c_storage_id returning storage_id into deleted_storage;
    RETURN deleted_storage;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_recipe_doctor
    ( 
        c_doctor_name VARCHAR2
    ) RETURN SYS_REFCURSOR as
    c_recipe SYS_REFCURSOR;
    BEGIN
    OPEN c_recipe FOR
        select * from recipes where recipe_doctor like c_doctor_name;
        RETURN c_recipe;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
     
    FUNCTION get_recipe_date
    ( 
        c_expite_date DATE
    )RETURN SYS_REFCURSOR as
    c_recipe SYS_REFCURSOR;
    BEGIN
    OPEN c_recipe FOR
        select * from recipes where recipe_expiredate < c_expite_date;
        RETURN c_recipe;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION create_recipe
    (
        c_doctor VARCHAR2,
        c_signature VARCHAR2,
        c_expiredate DATE
    )RETURN NUMBER AS
    created_recipe NUMBER;
    BEGIN
        INSERT INTO recipes(recipe_doctor, recipe_signature, recipe_expiredate)
        values(c_doctor, c_signature, c_expiredate)returning recipe_id into created_recipe;
        return created_recipe;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION alter_recipe
    (
        recipe_toupdate_id NUMBER,
        c_doctor VARCHAR2,
        c_signature VARCHAR2,
        c_expiredate DATE
    )RETURN NUMBER AS
    BEGIN
        IF c_doctor is NOT NULL THEN
            UPDATE recipes set recipe_doctor = c_doctor where recipe_id=recipe_toupdate_id;
        END IF;
        IF c_signature is NOT NULL THEN
            UPDATE recipes set recipe_signature = c_signature where recipe_id=recipe_toupdate_id;
        END IF;
        IF c_expiredate is NOT NULL THEN
            UPDATE recipes set recipe_expiredate = c_expiredate where recipe_id=recipe_toupdate_id;
        END IF;
        RETURN recipe_toupdate_id;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION delete_recipe
    (
        c_recipe_id NUMBER 
    )RETURN NUMBER AS
    deleted_recipe NUMBER;
    BEGIN
        delete from recipes where recipe_id=c_recipe_id returning recipe_id into deleted_recipe;
    RETURN deleted_recipe;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;

END manager_pack;