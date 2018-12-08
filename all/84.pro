domains
	i = integer % целое число
	list = i* % список целых чисел
	bi_t = tree_b(bi_t, i, bi_t); nil % функтор бинарного дерева (из лекций)


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% предикаты для бинарных деревьев
	% выводит бинарное дерево (от левого края)
	nondeterm map(bi_t, i)
	% делает отступ слева (выводит на консоль табуляцию D раз)
	nondeterm tab(i)
	% создаёт бинарное дерево как бинарный справочник (вводит с консоли)
	nondeterm create_tree(bi_t, bi_t)
	% вставляет элемент в бинарный справочник
	nondeterm insert(i, bi_t, bi_t)
	% задание 84 - Напечатать путь от корня к указанной вершине в бинарном справочнике
	nondeterm task_84(bi_t, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 84\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 84
		write("Enter tree: "), nl,
		create_tree(nil, Tree),
		write("Enter vertex: "), readint(V),
		task_84(Tree, V, Path),
		write("Path: ", Path), nl.


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


	% бинарное дерево
	% выводим дерево на консоль (предикат из лекций)
	map(nil, _).
	map(tree_b(Left, E, Right), D) :-
		NewD = D + 1,
		map(Right, NewD),
		tab(D), write(E), nl,
		map(Left, NewD).
	
	% делаем D отступов  (из лекций)
	tab(0).
	tab(D) :-
		write("\t"),
		NewD = D - 1,
		tab(NewD).

	% созадём дерево (из лекций)
	create_tree(Tree, NewTree) :-
		readint(C),!,
		insert(C, Tree, TempTree),
		nl, map(TempTree, 0),
		write("----------------------------------------------------------------------"), nl,
		create_tree(TempTree, NewTree). 
	
	create_tree(Tree, Tree).
	
	% вставляем элемент в дерево  (из лекций)
	insert(New, nil, tree_b(nil, New, nil)).
	insert(E, tree_b(Left, E, Right), tree_b(Left, E, Right)).
	
	insert(New, tree_b(Left, E, Right), tree_b(NewLeft, E, Right)) :-
		New < E,
		insert(New, Left, NewLeft).
		
	insert(New, tree_b(Left, E, Right), tree_b(Left, E, NewRight)) :-
		E < New,
		insert(New, Right, NewRight).


	% задание 84 - Напечатать путь от корня к указанной вершине в бинарном справочнике
	% Если деерво закончилось - делаем откат, искомая вершина не найдена
	% Если текущая вершина равна искомой - то это конец пути
	% Если текущая вершина не равна искомой, то заносим её в список и повторяем процесс
	% для левого поддерева. Если поиск в левом поддереве не удался, то ищем её в правом
	task_84(nil, _, _) :- fail.
	task_84(tree_b(_, V, _), V, [V]).
	task_84(tree_b(nil, _, nil), _, _) :- fail.
	task_84(tree_b(L, E, _), V, [E|T]) :- task_84(L, V, T).
	task_84(tree_b(_, E, R), V, [E|T]) :- task_84(R, V, T).




goal go.

