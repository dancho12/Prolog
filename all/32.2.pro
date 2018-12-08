domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	nondeterm add_end(i, list, list) % добавляет элемент в конец списка
    % задание 32.2 - создаёт список из элементов с чётных (нечётных позиций) исходного списка
    nondeterm task_32(list, i, list, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 32.2\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 32.2
        write("LIST 1: "), nl, readList(ListA),
        write("LIST 2: "), nl, readList(ListB),
        write("LIST 1: ", ListA), nl,
        write("LIST 2: ", ListB), nl,
        StartA = 0, % для нечётных позиций
        task_32(ListA, StartA, [], R1),
        StartB = 1, % для чётных позиций
        task_32(ListB, StartB, R1, R2),
        write("RESULT: ", R2), nl.


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


	% добавляет элемент в конец списка (из лекций)
	add_end(X, [H|T], [H|Tf]) :- add_end(X, T, Tf).
	add_end(X, [], [X]).


    % задание 32.2 - создаёт список из элементов с чётных позиций исходного списка
    % создаёт список из элементов на чётных позициях, основываясь на переданном числе,
    % которое считается началом отсчёта. Если передана 1 или любое нечётное – то будут элементы с чётных позиций,
    % но если передать любое чётное число, то будут элементы с нечетных позиций
    % Предикат добавляет элемент в конец существующего списка, а не создаёт новый
    % специально для условий задания, что бы можно было добавить в конец уже частично сформированного списка
    task_32([], _, ListResult, ListResult).
    
    task_32([H|T], Counter, PrevList, ListResult) :-
        Counter mod 2 = 0,
        NextCounter = Counter + 1,
        add_end(H, PrevList, NewList),
        task_32(T, NextCounter, NewList, ListResult).
        
    task_32([_|T], Counter, PrevList, ListResult) :-
        NextCounter = Counter + 1,
        task_32(T, NextCounter, PrevList, ListResult).




goal go.

