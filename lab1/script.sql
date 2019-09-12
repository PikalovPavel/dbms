create or replace procedure variables
is
obj_type varchar(100);


BEGIN
DBMS_OUTPUT.enable(800000);
DBMS_OUTPUT . PUT_LINE ('Имя схемы : s174692 ');

DBMS_OUTPUT . PUT_LINE('No . Имя Пакета Тип объекта Имя объекта ' );
DBMS_OUTPUT . PUT_LINE('____ ____________ ____________ ___________');

for row in ( SELECT rownum , object_name , type , name from user_ identifiers 
            WHERE object_type in ( 'PACKAGE' , 'PACKAGE BODY' ) 
            and usage='DECLARATION' and type in
            ('VARIABLE' , 'CONSTANT' ) and usage_context_id in 
            ( SELECT usage_id FROM
            user_identifiers WHERE type ='PACKAGE' ))
 loop
 if row . type = 'VARIABLE' then
 obj_type := Переменная ' ';
end if;

 if row . type = 'CONSTANT' then
obj_type := Константа ' ';
 end if ;

DBMS_OUTPUT . PUT_LINE(RPAD( row . rownum , 4 ) | | ' ' | | RPAD( row . object_name , 12 ) | |
' ' | | RPAD( obj_type , 12 ) | | ' ' | | RPAD( row . name , 30 ) ) ;
end loop;

 END
/