CREATE OR REPLACE Procedure variables(schemeName in varchar2)
IS 
obj_type varchar(100);

BEGIN
	DBMS_OUTPUT.enable(800000);
	DBMS_OUTPUT.PUT_LINE ('Имя схемы: ' || schemeName);

	DBMS_OUTPUT.PUT_LINE('No . Имя Пакета Тип объекта Имя объекта');
	DBMS_OUTPUT.PUT_LINE('____ ____________ ____________ ___________');

	FOR row IN (SELECT rownum, object_name, type, name from all_identifiers 
		WHERE owner = schemeName
		AND object_type in ('PACKAGE', 'PACKAGE BODY') 
		AND usage = 'DECLARATION' 
		AND type IN ('VARIABLE', 'CONSTANT') 
		AND usage_context_id IN 
			(SELECT usage_id FROM all_identifiers 
			WHERE type ='PACKAGE'))
	LOOP
		IF row.type = 'VARIABLE' THEN
 			obj_type := 'Переменная';
		END IF;

		IF row.type = 'CONSTANT' THEN
			obj_type := 'Константа';
		END IF;

		DBMS_OUTPUT.PUT_LINE(RPAD(row.rownum, 4) || ' ' || RPAD(row.object_name, 12) || ' ' || RPAD(obj_type, 12) || ' ' || RPAD(row.name, 30));
	END LOOP;

END;
/
