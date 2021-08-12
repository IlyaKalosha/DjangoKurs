CREATE ROLE developer;

GRANT CREATE SESSION TO developer;
GRANT CREATE TABLE TO developer;
GRANT CREATE TABLESPACE TO developer;
GRANT ALTER TABLESPACE TO developer;
GRANT DROP TABLESPACE TO developer;
GRANT INSERT ANY TABLE, SELECT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE TO developer;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO developer;
GRANT CREATE ANY DIRECTORY TO developer;
GRANT CREATE ANY TRIGGER TO developer;

CREATE ROLE manager;

GRANT execute on dev_il.manager_pack TO manager;
GRANT execute on dev_il.manager_pack TO developer;

GRANT CREATE SESSION TO manager;

CREATE ROLE seller;

GRANT execute on dev_il.seller_pack TO seller;
GRANT CREATE SESSION TO seller;

CREATE USER dev_il IDENTIFIED BY Qwerty123;
GRANT developer TO dev_il;
GRANT UNLIMITED TABLESPACE TO dev_il;


CREATE USER manager_il IDENTIFIED BY Qwerty123;
GRANT manager TO manager_il;

CREATE USER seller_il IDENTIFIED BY Qwerty123;
GRANT seller TO seller_il;