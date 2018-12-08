domains
	i = integer % целое число
	list = i* % список целых чисел
	multiList = list*


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% считает количество вхождений элемента в список
	nondeterm elementCount(list, i, i)
	nondeterm add_end(i, list, list) % добавляет элемент в конец списка
	% задание 71 – создаёт список пар в которых первая компонента – элемент исходного списка, вторая – число его подряд идущих повторений.
	% списка, вторая – число его подряд идущих повторений
	nondeterm task_71_repeatedElements(list, list, multiList)
	% создаёт список уникальных элементов исходного списка (без повторений)
	nondeterm task_71_singleElements(list, list, list)
	% вычисляет количество подряд идущих повторений элемента
	nondeterm task_71_repeatCount(list, i, i)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 71\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 71
		write("LIST: "), nl, readList(L), nl,
		write("LIST: ", L), nl,
		% удаляем повторения из списка (получаем уникальные элементы)
		task_71_singleElements(L, [], SingleElements),
		% составляем пары
		task_71_repeatedElements(L, SingleElements, RP),
		write("REPEATS: ", RP), nl.


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


	% подсчитываем количество вхождений элемента в список
	% идёт по списку и сравнивает каждый элемент с искомым, если они равны, то
	% количество вхождений элемента равно 1 + количество вхождений элемента в хвост списка
	elementCount([], _, 0).
	
	elementCount([H|T], El, Res) :-
		H = El,
		elementCount(T, El, NewRes),
		Res = NewRes + 1, !.
	
	elementCount([_|T], El, Res) :-
		elementCount(T, El, Res).


	% добавляет элемент в конец списка (из лекций)
	add_end(X, [H|T], [H|Tf]) :- add_end(X, T, Tf).
	add_end(X, [], [X]).


		% задание 71 – создаёт список пар в которых первая компонента – элемент исходного списка, вторая – число его подряд идущих повторений.
	% создаём список пар, используя на список уникальных элементов, переданных в предикат и предикаты, приведённые ниже
	task_71_repeatedElements(_, [], []).
	task_71_repeatedElements(L, [H|T], [[H, RP]|DT]) :- task_71_repeatCount(L, H, RP), task_71_repeatedElements(L, T, DT).
	
	% подсчитывает количество подряд идущих повторений, увеличивая счётчик на единицу
	% при обнаружении пары элементов, равных между собой и равных заданному
	task_71_repeatCount([], _, 0).
	task_71_repeatCount([_], _, 0).
	task_71_repeatCount([C|[C|T]], C, RP) :- task_71_repeatCount([C| T], C, NR), RP = NR + 1.
	task_71_repeatCount([_|T], C, RP) :- task_71_repeatCount(T, C, RP).

	% получает список уникальных элементов из списка (т.е. удаляет все повторения каждого элемента)
	% для этого идём по исходному списку и подсчитываем количество каждого элемента в списке-результате,
	% если оно не равно 0, то элемент, значит, уже добавлен и мы его пропускаем, если равно 0, то добавляем в конец
	task_71_singleElements([], SingleList, SingleList).
	task_71_singleElements([H|T], NewList, SingleList) :-
		elementCount(NewList, H, Count),
		Count = 0,
		add_end(H, NewList, NextNewList),
		task_71_singleElements(T, NextNewList, SingleList).
		
	task_71_singleElements([_|T], NewList, SingleList) :-
		task_71_singleElements(T, NewList, SingleList).




goal go.

