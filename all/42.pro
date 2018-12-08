domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	nondeterm length(list, i) % вычисляет длину списка
	% задание 42 - заменяет N последних элементов списка на заданную константу.
	nondeterm task_42(list, i, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 42\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 42
		readList(L), nl,
		write("List: ", L), nl,
		write("N: "), readint(N),
		write("C: "), readint(C),
		length(L, Length),
		From = Length - N,
		task_42(L, From, C, R),
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


	% вычисляет длину списка
	length([], 0). % длина пустого списка - 0
	length([_|T], L) :-
		length(T, TL),
		L = 1 + TL. % длина списка на 1 больше длины его хвоста


	% задание 42 - заменяет N последних элементов списка на заданную константу.
	% в этот предикат в качестве N передаётся не количество элементов, а длина
	% списка минус количество элементов, то есть, позиция, с которой нужно заменять элементы
	% идём по списку, уменьшая N на 1 и копируя элементы в результатирующий список, когда N
	% стала равна 1 (мы дошли до позиции N), то начинаем ставить в голову результата константу C
	task_42([], _, _, []).
	
	task_42([H|T], N, C, [H|RT]) :-
		N > 0,
		NewN = N - 1,
		task_42(T, NewN, C, RT).
		
	task_42([_|T], N, C, [C|RT]) :-
		task_42(T, N, C, RT).




goal go.

