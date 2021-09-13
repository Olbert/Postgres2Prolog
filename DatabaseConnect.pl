openDatabase :- //Соединение с базой
odbc_connect('postgresqlProlog',
_,[ user(postgres),password('1234'),  //Стандартная функция. Включить базу с заданными параметрами логина и пароля
alias(postgresqlProlog),open(once)]).

closeDatabase:-
odbc_disconnect(postgresqlProlog).  //Стандартная функция. Отключить базу

getNameConnection:-
odbc_current_connection(Alias,Dsn),  //Стандартная функция. Получить имя базы 
write('Alias'-Alias),nl,
write('Dsn'-Dsn).

getPropertyConnection:-  //Получение различных характеристик соединения
odbc_get_connection('postgresqlProlog',database_name(Change1)),
odbc_get_connection('postgresqlProlog',dbms_name(Change2)),
odbc_get_connection('postgresqlProlog',dbms_version(Change3)),
odbc_get_connection('postgresqlProlog',driver_name(Change4)),
odbc_get_connection('postgresqlProlog',driver_version(Change5)),
odbc_get_connection('postgresqlProlog',driver_odbc_version(Change6)),
odbc_get_connection('postgresqlProlog',active_statements(Change7)),
write('Database Name' -Change1), nl,
write('Database Engine' -Change2), nl,
write('Engine version' -Change3), nl,
write('Driver Name' -Change4), nl,
write('driver version' -Change5), nl,
write('ODBCC Version' -Change6), nl,
write('Active Query' -Change7), nl.

getDataSource:- 
odbc_data_source(DSN,Description),
write(DSN+Description).

getTables:-  //Получения списка всех таблиц
odbc_current_table(postgresqlProlog,Table),
write(Table).

getColumns:-  //Получения списка всех столбцов всех таблиц
odbc_table_column(postgresqlProlog,Table,Column),
write(Table-Column).


getColumns(Table):- //Получения списка всех столбцов заданой таблицы
odbc_table_column(postgresqlProlog,Table,Column),
write(Table-Column).


getPersonsList:- //Получения списка всех записей из таблицы "Person"
odbc_query(postgresqlProlog,'SELECT * from "Person"' ,Row,[]), // Запрос к базе(имя_драйвера,строка_запроса,Выходная_переменнная, значение_полей_выходной_переменной(опционально))
write(Row).

getList(Table):- //Получения списка всех записей заданой таблицы
openDatabase,
concat('SELECT * from "',Table,X), // "Склеить" строки в переменную X
concat(X,'"',Y), // Добавить в переменную X закрывающую кавычку и занести значение в переменную Y
odbc_query(postgresqlProlog,Y ,Row,[types([integer,string,string,string])]), // Запрос к базе.
write(Y),
write(Row),
write_in(Row).//Вывод в файл(описано в File.pl

getList(Table,Id):-//Получения строки с заданым id
openDatabase,
concat('SELECT * from "',Table,X),
concat(X,'" where id =',Y),
concat(Y,Id,Z),
odbc_query(postgresqlProlog,Z ,Row,[types([integer,string,string,string])]),
write_in(Row).


updateList(Table,Id,Name,Value):-//Апдейт строки с заданым id
openDatabase,
concat('UPDATE "',Table, X1),
concat(X1,'" SET ',X2),
concat(X2,Name,X3),
concat(X3,' = ',X4),
concat(X4,Value,X5),
concat(X5,' WHERE id = ',X6),
concat(X6,Id,X),
odbc_query(postgresqlProlog,X, Affected,[types([integer,string,string,string])]),
write(Affected).

deleteList(Table,Id):-//Удаление строки с заданым id
openDatabase,
concat('DELETE from "',Table,X),
concat(X,'" WHERE Id = ',Y),
concat(Y,Id,Z),
odbc_query(postgresqlProlog,Z, Affected,[types([integer,string,string,string])]),
write(Affected).

deleteList(Table,Name,Value):-//Удаление строки с заданым значением, заданного поля
openDatabase,
concat('DELETE from "',Table,X1),
concat(X1,'" WHERE ',X2),
concat(X2,Name,X3),
concat(X3,' = ',X4),
concat(X4,Value,X),
odbc_query(postgresqlProlog,X, Affected,[types([integer,string,string,string])]),
write(Affected).















