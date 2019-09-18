SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE variables(schemeName IN VARCHAR2)
IS
obj_type VARCHAR(100);
numbers_space NUMBER := 4;
packet_name NUMBER := 12;
variable_name NUMBER := 30;
BEGIN
        DBMS_OUTPUT.enable(800000);
        DBMS_OUTPUT.PUT_LINE('Имя схемы: ' || schemeName);
        DBMS_OUTPUT.PUT_LINE('No . Имя Пакета   Тип объекта  Имя объекта');
        DBMS_OUTPUT.PUT_LINE(RPAD('_', numbers_space, '_') || ' ' ||
        RPAD('_', packet_name, '_') || ' ' ||
        RPAD('_', packet_name, '_') || ' ' ||
        RPAD('_', variable_name, '_'));
        FOR ROW IN (SELECT ROWNUM, name, TYPE, object_name FROM all_identifiers
                WHERE owner = schemeName
                AND TYPE IN ('VARIABLE', 'CONSTANT')
                AND object_type IN ('PACKAGE', 'PACKAGE BODY')
                AND usage = 'DECLARATION'
                AND usage_context_id IN
                        (SELECT usage_id FROM all_identifiers
                        WHERE TYPE ='PACKAGE'))
        LOOP
                IF ROW.TYPE = 'VARIABLE' THEN
                        obj_type := 'Переменная';
                END IF;
                IF ROW.TYPE = 'CONSTANT' THEN
                        obj_type := 'Константа';
                END IF;
        DBMS_OUTPUT.PUT_LINE(RPAD(ROW.ROWNUM, numbers_space) || ' ' ||
        RPAD(ROW.object_name, packet_name) || ' ' ||
        RPAD(obj_type, packet_name) || ' ' ||
        RPAD(ROW.name, variable_name));
END LOOP;
END;
/