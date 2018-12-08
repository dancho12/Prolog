domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задача 26 - Заменить в исходном списке N-ый элемент заданной константой.
	nondeterm task_26(list, i, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 26\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 26
		write("List: "), nl, readList(L),
		write("N = "), readint(N),
		write("C = "), readint(C),
		task_26(L, N, C, R),
		write("Result: ", R), nl.


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


	% задача 26 - Заменить в исходном списке N-ый элемент заданной константой.
	% идём по списку и уменьшаем N на 1 на каждом элементе, и копируем элементы в конечный список
	% и когда N = 0, значит, мы дошли до нужного элемента, помещаем в результат константу вместо исходного элемента
	task_26([], _, _, []).
	task_26([_|T], 1, C, [C|RT]) :- task_26(T, 0, C, RT).
	task_26([H|T], N, C, [H|R]) :- N2 = N - 1, task_26(T, N2, C, R).




goal go.

