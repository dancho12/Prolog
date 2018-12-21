domains
    i = integer
    list = i*
    multiList = list*
 
 
predicates
    nondeterm go
    nondeterm do(char)
    nondeterm readList(list)
 
    nondeterm task_71(list, i, multiList)
 
 
clauses
    go :-
        write("=== SELECT TASK ===\n"),
        write("Press 1 - task 71\n"),
        write("Press 0 - to exit\n\n"),
        write("Task: "), readchar(A),
        write(A), nl, do(A),
        go.
 
    do('1') :-
        write("LIST: "), nl, readList(L), nl,
        write("LIST: ", L), nl,
   
        task_71(L, 0, R),
        write("REPEATS: ", R), nl.
 
 
    do('0') :-
        write("Good bye!"), nl,
        exit.
 
 
    readList([H|T]) :-
        write("Add element: "),
        readint(H),
        readList(T).
   
 
    readList([]).
   
    task_71([H], N, [[H,N]]).
    task_71([H,H|T], N, R) :- NewN = N + 1, task_71([H|T], NewN, R).
    task_71([H1,H2|T], N, [[H1, N]|RT]) :- task_71([H2|T], 0, RT).
 
goal go.


