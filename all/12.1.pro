domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 12.2 - Вычислить сумму элементов списка, находящихся на нечётных позициях.
	nondeterm task_12(list, i, i)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 12.1\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 12.1
		write("LIST: "), nl, readList(L),
		write("LIST: ", L), nl,
		task_12(L, 1, Summ),
		write("Summ of elements on even positions: ", Summ), nl.


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


	% задание 12.1 - Вычислить сумму элементов списка, находящихся на чётных позициях.
	% На основе счётчика (N), который на каждом элементе увеличивается на 1, проверяем является
	% ли текущая позиция нечётной (остаток от деления счётчика на 2 равен 0), и если да, то
	% сумма будет равна текущему элементу + сумме элементов на нечётных позициях хвоста
	task_12([], _, 0).

	task_12([H|T], N, S) :-
		N mod 2 = 0,
		NewN = N + 1,
		task_12(T, NewN, TailS),
		S = TailS + H.
		
	task_12([_|T], N, S) :-
		NewN = N + 1,
		task_12(T, NewN, S).




goal go.

