domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 37 - Подсписок, в котором нет К первых элементов исходного списка.
	nondeterm task_37(list, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 37\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 37
		readList(LIST),
		write("List: ", LIST), nl,
		write("K: "), readint(K),
		task_37(LIST, K, RESULT),
		write("Result: ", RESULT), nl.


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


	% задание 37 - Подсписок, в котором нет К первых элементов исходного списка.
	% пока K > 0, пропускаем элементы и уменьшаем K на каждом элементе
	% как только К дойдёт до 0, начинаем копировать элементы в конечный список
	task_37([], _, []).
	
	task_37([SH|ST], K, [RH|RT]) :- 
		K < 1,
		NewK = K - 1,
		RH = SH,
		task_37(ST, NewK, RT).
		
	task_37([_|ST], K, Result) :-
		NewK = K - 1,
		task_37(ST, NewK, Result).




goal go.

