domains
	i = integer % целое число
	list = i* % список целых чисел


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% задание 19 - Создать список из N начальных чисел ряда Фибоначчи
	nondeterm task_19(i, i, i, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 19\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 19
		write("N = "), readint(N),
		task_19(N, 0, 0, R),
		write(R), nl.


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


	% задание 19 - Создать список из N начальных чисел ряда Фибоначчи
	% если предыдущие числа равны 0 и 0, то мы находимся в начале ряда
	% устанавливаем первое число в 1
	% если предыдущие числа равны 0 и 1, то мы на втором элементе ряда
	% а он тоже будет единицей
	% для остальных случаев новое число равно сумме двух предыдущих
	% при этом в рекурсию мы передаём уже второе предыдущее и текущее число
	% N - счётчик, который уменьшается на 1 с каждым числом, и процесс остановится
	% когда он будет равен 0 (вернётся пустой список)
	task_19(0, _, _, []).
	task_19(N, 0, 0, [1|T]) :- N2 = N - 1, task_19(N2, 1, 0, T).
	task_19(N, 1, 0, [1|T]) :- N2 = N - 1, task_19(N2, 1, 1, T).
	task_19(N, A, B, [C|T]) :-
		C = A + B,
		N2 = N - 1,
		task_19(N2, B, C, T).




goal go.

