domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 53 – вставляет один список в другой, начиная с N-ной позиции
	nondeterm task_53(list, i, list, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 53\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 53
		write("LIST 1: "), nl, readList(L1),
		write("LIST 2: "), nl, readList(L2),
		write("LIST 1: ", L1), nl,
		write("LIST 2: ", L2), nl,
		write("N = "), readint(N),
		task_53(L1, N, L2, R),
		write("RESULT: ", R), nl.


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


	% задание 53 – вставляет один список в другой, начиная с N-ной позиции
	% идём по списку, уменьшая N на 1 для каждого элемента и копируем каждый
	% элемент из исходного списка в результат, и если N равно 1, то вставляем
	% элементы из 2 списка, пока они не кончатся (пока хвост 2 списка не будет пустым),
	% затем продолжаем вставлять элементы из 1 
	task_53([], _, [], []).
	task_53([H1|T1], N, L2, [H1|RT]) :- N > 1, NextN = N - 1, task_53(T1, NextN, L2, RT).
	task_53([H1|T1], N, [], [H1|RT]) :- task_53(T1, N, [], RT).       
	task_53(L1, N, [H2|T2], [H2|RT]) :- task_53(L1, N, T2, RT).




goal go.

