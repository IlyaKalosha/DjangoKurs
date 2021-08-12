CREATE OR REPLACE PACKAGE seller_pack AS 
    
    FUNCTION get_recipe
    (
        c_recipe_id NUMBER
    )RETURN SYS_REFCURSOR;
    
    FUNCTION check_item_local
    (
        item_name VARCHAR2,
        pharmacy_id NUMBER
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION check_item_global
    (
        item_name VARCHAR2
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION check_category_local
    (
        category_name VARCHAR2,
        pharmacy_id NUMBER
    )  RETURN SYS_REFCURSOR;
    
    FUNCTION check_category_global
    (
        category_name VARCHAR2
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION create_order
    (
        seller_id NUMBER,
        pharmacy_id VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION add_to_basket
    (
        basket_order_id number,
        basket_pill_id NUMBER,
        basket_pill_count NUMBER,
        pharmacy_id NUMBER
    ) RETURN number;
    
    FUNCTION create_check_getinfo
    (
        current_order_id orders.order_id%type
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION create_check_getorder
    (
        current_order_id orders.order_id%type
    ) RETURN SYS_REFCURSOR;
    
    FUNCTION login
    (
        user_login seller.seller_login%TYPE,
        user_pass seller.seller_pass%TYPE
    ) RETURN SYS_REFCURSOR;
END seller_pack;

CREATE OR REPLACE PACKAGE BODY seller_pack AS  
    FUNCTION create_check_getinfo
    (
        current_order_id orders.order_id%type
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT ORDER_ID, ORDER_DATE, pharmacy.pharmacy_city, pharmacy.pharmacy_street,pharmacy.pharmacy_phone, seller.seller_name,seller.seller_surname,seller.seller_fathername
        from orders join pharmacy on orders.order_pharmacy_id=pharmacy.pharmacy_id
        join seller on seller.seller_id=orders.order_seller_id where orders.order_id=current_order_id;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION create_check_getorder
    (
        current_order_id orders.order_id%type
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT BASKET_PILL_ID, BASKET_PILL_COUNT,PILL_NAME,PILL_COST,PILL_BARCODE, BASKET_PILL_COUNT*PILL_COST
        from ORDERS join BASKET on basket.basket_order_id = orders.order_id 
        join pills on BASKET.BASKET_PILL_ID=pills.pill_id where orders.order_id=current_order_id;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION add_to_basket
    (
        basket_order_id number,
        basket_pill_id NUMBER,
        basket_pill_count NUMBER,
        pharmacy_id NUMBER
    ) RETURN NUMBER AS
    NO_SUCH_COUNT EXCEPTION;
    PRAGMA EXCEPTION_INIT (NO_SUCH_COUNT, -10001);
    res NUMBER;
    pill_c NUMBER;
    BEGIN
        select  STORAGE_PILL_COUNT INTO PILL_C from storage where storage.storage_pill_id=basket_pill_id AND ROWNUM=1 AND storage_pharmacy_id=pharmacy_id;
        IF basket_pill_count<pill_c
        THEN
        INSERT INTO basket(basket_order_id, basket_pill_id, basket_pill_count) VALUES (basket_order_id, basket_pill_id, basket_pill_count) returning basket_id into res;
        UPDATE STORAGE set storage_pill_count = storage_pill_count - basket_pill_count where storage_pill_id=basket_pill_id and storage_pharmacy_id=pharmacy_id;
        ELSE
            RAISE NO_SUCH_COUNT;
        END IF;
        RETURN res;
    EXCEPTION
    WHEN NO_SUCH_COUNT THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION: NO SUCH COUNT OF ELEMENTS AT STORAGE');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION create_order
    (
        seller_id NUMBER,
        pharmacy_id VARCHAR2
    ) RETURN NUMBER AS
    res NUMBER;
    BEGIN
        INSERT INTO orders(order_seller_id, order_pharmacy_id, order_date) VALUES (seller_id, pharmacy_id,TO_DATE(sysdate,'yyyy/mm/dd HH24-MI-SS')) returning order_id into res;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION get_recipe
    (
        c_recipe_id NUMBER
    )RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT * from recipes where recipe_id=c_recipe_id;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION check_item_local
    (
        item_name VARCHAR2,
        pharmacy_id NUMBER
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT * from pills join storage on pills.pill_id = storage.storage_pill_id where CATSEARCH(pill_name, item_name, NULL)>0 AND storage.storage_pharmacy_id=pharmacy_id;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION check_item_global
    (
        item_name VARCHAR2
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT * from pills join storage on pills.pill_id = storage.storage_pill_id where CATSEARCH(pill_name, item_name,NULL)>0;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION check_category_local
    (
        category_name VARCHAR2,
        pharmacy_id NUMBER
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT * from pills join storage on pills.pill_id = storage.storage_pill_id where CATSEARCH(pill_category, category_name,NULL)>0 AND storage.storage_pharmacy_id=pharmacy_id;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION check_category_global
    (
        category_name VARCHAR2
    ) RETURN SYS_REFCURSOR AS
    res SYS_REFCURSOR;
    BEGIN
        OPEN res FOR
        SELECT * from pills join storage on pills.pill_id = storage.storage_pill_id where CATSEARCH(pill_category, category_name,NULL)>0;
        RETURN res;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
    
    FUNCTION login
    (
        user_login seller.seller_login%TYPE,
        user_pass seller.seller_pass%TYPE
    ) RETURN SYS_REFCURSOR  AS
    c_user SYS_REFCURSOR;
    BEGIN
        OPEN c_user for
        select * from seller where seller.seller_login = user_login and seller_pass = user_pass;
        RETURN (c_user);
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    RETURN NULL;
    END;
END seller_pack;