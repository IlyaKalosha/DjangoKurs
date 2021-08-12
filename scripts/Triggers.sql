CREATE OR REPLACE TRIGGER basket_trigger_after
    after insert or update or delete on basket
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType, Table_Name, Data)
        SELECT sysdate,'Insert', 'basket', basket.basket_id 
        FROM basket where rownum=1 order by basket.basket_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'basket', basket.basket_id
        FROM basket;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'basket', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER manager_trigger_after
    after insert or update or delete on manager
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'manager', manager.manager_id 
        FROM manager where rownum=1 order by manager.manager_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'manager', manager.manager_id
        FROM manager;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'manager', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER orders_trigger_after
    after insert or update or delete on orders
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'orders', orders.order_id 
        FROM orders where rownum=1 order by orders.order_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'orders', orders.order_id
        FROM orders;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'orders', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER pharmacy_trigger_after
    after insert or update or delete on pharmacy
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'pharmacy', pharmacy.pharmacy_id 
        FROM pharmacy where rownum=1 order by pharmacy.pharmacy_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'pharmacy', pharmacy.pharmacy_id
        FROM pharmacy;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'pharmacy', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER pills_trigger_after
    after insert or update or delete on storage
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'pills', pills.pill_id 
        FROM pills where rownum=1 order by pills.pill_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'pills', pills.pill_id
        FROM pills;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'pills', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER recipes_trigger_after
    after insert or update or delete on recipes
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'recipes', recipes.recipe_id 
        FROM recipes where rownum=1 order by recipes.recipe_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'recipes', recipes.recipe_id
        FROM recipes;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'recipes', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER seller_trigger_after
    after insert or update or delete on seller
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'seller', seller.seller_id 
        FROM seller where rownum=1 order by seller.seller_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'seller', seller.seller_id
        FROM seller;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'seller', 'delete'
        FROM dual;
    END if;
END;

CREATE OR REPLACE TRIGGER storage_trigger_after
    after insert or update or delete on storage
BEGIN
    if inserting then
        dbms_output.put_line('after_insert_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Insert', 'storage', storage.storage_id 
        FROM storage where rownum=1 order by storage.storage_id desc;
    elsif updating then
        dbms_output.put_line('after_update_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name,Data  )
        SELECT sysdate,'Update', 'storage', storage.storage_id
        FROM storage;
    elsif deleting then
        dbms_output.put_line('after_delete_storage');
        INSERT INTO AUDITS(OperationDate,OperationType , Table_Name, Data )
        SELECT sysdate,'Delete', 'storage', 'delete'
        FROM dual;
    END if;
END;