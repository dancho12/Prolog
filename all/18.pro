domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 18 - Удалить отрицательные элементы списка
	nondeterm task_18(list, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 18\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 18
		write("LIST: "), nl, readList(LIST), nl,
		write("LIST: ", LIST), nl,
		task_18(LIST, NewList),
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


	% задание 18 - Удалить отрицательные элементы списка
	% Если элемент списка >= 0, заносим его в список-результат
	% Если нет - пропускаем. И повторяем для хвостов списков. 
	% Для пустого списка результат - пуской список
	task_18([H|T], [H|T2]) :- H >= 0, task_18(T, T2).
	task_18([_|T], L2) :- task_18(T, L2).
	task_18([],[]).




goal go.

