domains
	i = integer
	list = i*


predicates
	nondeterm go
	nondeterm do(char)
	nondeterm readList(list)

	nondeterm elementCount(list, i, i)

	nondeterm task_48(list, list, list)


clauses
	go :-
		write("=== SELECT TASK ===\n"),
		write("Press 1 - task 48\n"),
		write("Press 0 - to exit\n\n"),
		write("Task: "), readchar(A),
		write(A), nl, do(A),
		go.

	do('1') :-
		write("LIST: "), nl, readList(L),
		write("LIST: ", L), nl,
		task_48(L, L, R),
		write("RESULT: ", R), nl.


	do('0') :-
		write("Good bye!"), nl,
		exit.


	readList([H|T]) :-
		write("Add element: "),
		readint(H),
		readList(T).
	

	readList([]).





	elementCount([], _, 0).
	
	elementCount([H|T], El, Res) :-
		H = El,
		elementCount(T, El, NewRes),
		Res = NewRes + 1, !.
	
	elementCount([_|T], El, Res) :-
		elementCount(T, El, Res).





	task_48(_, [], []).
	task_48(L, [H|T], [H|RT]) :- elementCount(L, H, C), C = 1, task_48(L, T, RT).
	task_48(L, [_|T], R) :- task_48(L, T, R).




goal go.

