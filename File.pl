
poisk(Id,T1,T2,T3):- //Функция поиска(не используется)
	send(T1,clear),	send(T2,clear),	send(T3,clear),
        row(Id,Fio,Phone,Profession),
	send(T1,append,Fio),
	send(T2,append,Phone),
	send(T3,append,Profession),
	fail.


write_in(Id, Fio,Phone,Profession) :- //Запись в файл заданных значений
    assert(
	 row(Id,Fio,Phone,Profession)),//Создание переменной row с параметрами
    FileName='C:/Users/iampi/Documents/Prolog/PrologPostgres Project/LocalBase.pl', //имя файла
    tell(FileName),//Открыть файл
    listing(row),//запись строки в открытый файл
    told.//Закрыть файл
	
write_in(Row) :-//Запись в файл заданной строки
    assert(Row),
    FileName='C:/Users/iampi/Documents/Prolog/PrologPostgres Project/LocalBase.pl',
    tell(FileName),
    listing(row),
    told.

delete_id(Id) :- //Удаление строки с заданым id
    retract(client(Id, _, _,   _, _, _)),
    FileName='C:/Users/iampi/Documents/Prolog/PrologPostgres Project/LocalBase.pl',
    tell(FileName),
    listing(row),
    told.

edit(Id, Fio,Phone,Profession) :-//Редактирование строки с задаными параметрами
    delete_id(Id),
    assert(row(Id,Fio,Phone,Profession)),
    FileName='C:/Users/iampi/Documents/Prolog/PrologPostgres Project/LocalBase.pl',
    tell(FileName),
    listing(row),
    told.
