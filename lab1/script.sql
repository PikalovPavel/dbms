SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE VARIABLES(schemeName IN varchar2)
IS
obj_type VARCHAR(100);
BEGIN
        DBMS_OUTPUT.enable(800000);
        DBMS_OUTPUT.PUT_LINE('Имя схемы: ' || schemeName);
        DBMS_OUTPUT.PUT_LINE('No . Имя Пакета Тип объекта Имя объекта');
        DBMS_OUTPUT.PUT_LINE('____ __________ ___________ ___________');
        FOR ROW IN (SELECT rownum, object_name, type, name FROM all_identifiers
                WHERE owner = schemeName
                AND object_type IN ('PACKAGE', 'PACKAGE BODY')
                AND usage = 'DECLARATION'
                AND TYPE IN ('VARIABLE', 'CONSTANT')
                AND usage_context_id IN
                        (SELECT usage_id FROM all_identifiers
                        WHERE TYPE ='PACKAGE'))
        LOOP
                IF ROW.type = 'VARIABLE' THEN
                        obj_type := 'Переменная';
                END IF;
                IF ROW.type = 'CONSTANT' THEN
                        obj_type := 'Константа';
                END IF;
        DBMS_OUTPUT.PUT_LINE(RPAD(ROW.rownum, 4) || ' ' || RPAD(ROW.object_name, 12) || ' ' || RPAD(obj_type, 12) || ' ' || RPAD(ROW.name,30));
END LOOP;
END;
/
