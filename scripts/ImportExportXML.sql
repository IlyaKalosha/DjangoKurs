----------------------DIR CREATE-------------------------------

CREATE OR REPLACE DIRECTORY XML_DIR AS 'Z:\oracle\scripts\XML';
select directory_path from all_directories; 
    
----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE EXPORT_STORAGE_TO_XML
IS
    DOC DBMS_XMLDOM.DOMDocument;
    XDATA XMLTYPE;
    CURSOR XMLCUR IS
        SELECT XMLELEMENT("STORAGE",
            XMLAttributes('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
            'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation"),
            XMLAGG(XMLELEMENT("ITEM",
                XMLELEMENT("ID",storage.storage_id),
                XMLELEMENT("PILL_ID",storage.storage_pill_id),
                XMLELEMENT("PILL_COUNT",storage.storage_pill_count),
                XMLELEMENT("PHARMACY_ID",storage.storage_pharmacy_id)
                ))
        )FROM storage;
BEGIN
    OPEN XMLCUR;
        LOOP
            FETCH XMLCUR INTO XDATA;
        EXIT WHEN XMLCUR%NOTFOUND;
        END LOOP;
    CLOSE XMLCUR;
    DOC:=DBMS_XMLDOM.NewDOMDocument(XDATA);
    DBMS_XMLDOM.WRITETOFILE(DOC, 'XML_DIR\storage.xml');
END;

------------------------------------------------------------

CREATE OR REPLACE PROCEDURE IMPORT_STORAGE_FROM_XML
IS
    L_CLOB CLOB;
    L_BFILE BFILE := BFILENAME('XML_DIR', 'storage.xml');
    
    L_DEST_OFFSET INTEGER :=1;
    L_SRC_OFFSET INTEGER :=1;
    L_BFILE_CSID NUMBER :=0;
    L_LANG_CONTEXT INTEGER :=0;
    L_WARNING INTEGER :=0;
    
    P DBMS_XMLPARSER.PARSER;
    V_DOC DBMS_XMLDOM.DOMDOCUMENT;
    V_ROOT_ELEMENT DBMS_XMLDOM.DOMELEMENT;
    V_CHILD_NODES DBMS_XMLDOM.DOMNODELIST;
    V_CURRENT_NODE DBMS_XMLDOM.DOMNODE;
    
    S STORAGE%ROWTYPE;
BEGIN
    DBMS_LOB.CREATETEMPORARY(L_CLOB, TRUE);
    DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
    DBMS_LOB.LOADCLOBFROMFILE(dest_lob=>L_CLOB,src_bfile=>L_BFILE,
        amount=>DBMS_LOB.LOBMAXSIZE,dest_offset=>L_DEST_OFFSET,src_offset=>L_SRC_OFFSET,
        bfile_csid=>L_BFILE_CSID,lang_context=>L_LANG_CONTEXT,warning=>L_WARNING);
    DBMS_LOB.FILECLOSE(L_BFILE);
    COMMIT;
    P := DBMS_XMLPARSER.NEWPARSER;
    DBMS_XMLPARSER.PARSECLOB(P, L_CLOB);
    V_DOC := DBMS_XMLPARSER.GETDOCUMENT(P);
    V_ROOT_ELEMENT := DBMS_XMLDOM.GETDOCUMENTELEMENT(V_DOC);
    V_CHILD_NODES := DBMS_XMLDOM.GETCHILDRENBYTAGNAME(V_ROOT_ELEMENT, '*');
    
    FOR i IN 0 .. DBMS_XMLDOM.GETLENGTH(V_CHILD_NODES) - 1
    LOOP
        V_CURRENT_NODE := DBMS_XMLDOM.ITEM(V_CHILD_NODES,i);
      
        DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,'PILL_ID/text()', S.STORAGE_PILL_ID);
        DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,'PILL_COUNT/text()', S.STORAGE_PILL_COUNT);
        DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,'PHARMACY_ID/text()', S.STORAGE_PHARMACY_ID);
        INSERT INTO storage(storage_pill_id,storage_pill_count,storage_pharmacy_id)
        values(S.STORAGE_PILL_ID,  S.STORAGE_PILL_COUNT, S.STORAGE_PHARMACY_ID);
    END LOOP;
    DBMS_LOB.FREETEMPORARY(L_CLOB);
    DBMS_XMLPARSER.FREEPARSER(P);
    DBMS_XMLDOM.FREEDOCUMENT(V_DOC);
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
              