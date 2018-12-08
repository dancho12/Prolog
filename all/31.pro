domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 31 – По списку элементов сформировать новый список элементов согласно списка порядковых номеров
	nondeterm task_31(list, list, list, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 31\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 31
		write("LIST OF ELEMENTS: "), nl, readList(LIST), nl,
		write("LIST OF NUMBERS: "), nl, readList(NUMS), nl,
		write("LIST OF ELEMENTS: ", LIST), nl,
		write("LIST OF NUMBERS: ", NUMS), nl,
		task_31(LIST, LIST, NUMS, 1, NewList),
		write("RESULT LIST: ", NewList), nl.


	do('0') :-
		write("Good bye!"), nl,
		exit.

	% ввод списка от пользователя
	readList([H|T]) :-
		write("Add element: "),
		readint(H), % читаем число и помещаем его в голову
		readList(T). % запускаем себя для хвоста
	
	% если введено не число – прекращаем рекурсию, возвращаем пустой список
	readList([]).


	% задание 31 – По списку элементов сформировать новый список элементов согласно списка порядковых номеров
	% идём по списку, сравнивая текущий элемент списка позиций с текущей позицией (POS)
	% Если они совпадают - то вставляем текущий элемент списка в результат, сбрасываем счётчик позиций,
	% и повторяем процесс заново для всего списка. Если же элемент списка позиций с текущей не совпал,
	% то двигаемся по списку дальше, пока не найдём нужную позицию и соответствующий ей элемент
	task_31(_, _, [], _, []).

	task_31(FullList, [H|_], [Pos|NT], Pos, [H|RT]) :-
		task_31(FullList, FullList, NT, 1, RT).

	task_31(FullList, [_|T], PosList, Pos, Res) :-
		NewPos = Pos + 1,
		task_31(FullList, T, PosList, NewPos, Res).




goal go.

