domains
	i = integer % целое число
	list = i* % список целых чисел
	tokenType = number;operation % тип токена в формуле (число или операция)
	tokenTypes = tokenType* % множество типов


predicates
	nondeterm go % главное меню программы
	nondeterm do(char) % запускает выполнение полученного на вход задания
	nondeterm readList(list) % вводит список от пользователя
	% первый этап чтения вводимой формулы - определение типа токена (число/операция) [n/o]
	nondeterm readFormula(list, tokenTypes)
	% второй этап чтения вводимой формулы - добавление токена в список токенов
	nondeterm saveToFormula(list, tokenTypes, char)
	% красиво выводит формулу
	nondeterm printFormula(list, tokenTypes)
	% задание 63 - вычисляет значение логической формулы по обратной польской записи
	nondeterm task_63(list, tokenTypes, list, i)

	% предикаты логических операций
	nondeterm op_or(i,i,i)
	nondeterm op_and(i,i,i)
	nondeterm op_xor(i,i,i)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 63\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :- % задание 63
		write("Enter formula: "), nl,
		readFormula(FORMULA, TYPES), nl,
		write("Formula: "), printFormula(FORMULA, TYPES), nl,
		write("Types: "), write(TYPES), nl,
		task_63(FORMULA, TYPES, [], R),
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


	% первый этап чтения вводимой формулы - определение типа токена (число/операция) [n/o]
	% читаем символ, если это Esc - прекращаем чтение формулы, если нет - запускаем saveToFormula
	readFormula(NUMS, TYPES) :-
		write("Token type [n]umber/[o]peration/[Esc]-stop: "),
		readchar(C),
		C <> 27, % escape key
		saveToFormula(NUMS, TYPES, C).
	
	readFormula([], []).
	
	% второй этап чтения вводимой формулы - 
	% добавляем токен - в список токенов, а его тип - в список типов
	% и читаем формулу дальше
	saveToFormula([NH|NT], [number|TT], 'n') :- write("N: "), readint(NH), readFormula(NT, TT).
	saveToFormula([NH|NT], [operation|TT], 'o') :- write("O: "), readchar(NH), writef("%c", NH), nl, readFormula(NT, TT).

	% красиво выводит формулу:
	% если очередной символ в ней - число, выводим как число
	% если операция - выводим как симво (char) (%c)
	printFormula([], []).
	printFormula([TOKEN|TOKENS], [number|TYPES]) :- write(TOKEN, ", "), printFormula(TOKENS, TYPES).
	printFormula([TOKEN|TOKENS], [operation|TYPES]) :- writef("%c", TOKEN), write(", "), printFormula(TOKENS, TYPES).


	% задание 62 - вычисляет значение логической формулы по обратной польской записи
	% Сначала читаем формулу, для числа вводим N, для операции - O
	% доступные логические операции: & (И), | (ИЛИ), ^ (М2)
	% и сохраняем в 2 списка: 1 - сами введенные данные, 2 - их тип (Ч/О)
	% Далее идём по формуле, если нам попадается число - помещаем его в стек
	% если попадается операция - берём последние 2 числа с верхушки стека,
	% применяем к ним операцию, кладём результат обратно на стек
	% если входные данные закончились - результат будет равен числу в стеке	
	task_63([NH|NT], [number|TT], STACK, R) :- task_63(NT, TT, [NH|STACK], R).
	task_63(['&'|NT], [operation|TT], [O2,O1|ST_T], R) :- op_and(O1,  O2, OpRes), task_63(NT, TT, [OpRes|ST_T], R).
	task_63(['|'|NT], [operation|TT], [O2,O1|ST_T], R) :- op_or(O1,  O2, OpRes), task_63(NT, TT, [OpRes|ST_T], R).
	task_63(['^'|NT], [operation|TT], [O2,O1|ST_T], R) :- op_xor(O1,  O2, OpRes), task_63(NT, TT, [OpRes|ST_T], R).
	task_63([], [], [R], R).

	% таблицы истинности логических операций
	op_and(0, 0, 0).
	op_and(_, 0, 0).
	op_and(0, _, 0).
	op_and(_, _, 1).
	
	op_or(0, 0, 0).
	op_or(_, _, 1).

	op_xor(0, 0, 0).
	op_xor(_, 0, 1).
	op_xor(0, _, 1).
	op_xor(_, _, 0).
	




goal go.

