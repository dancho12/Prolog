domains
list = integer*.

predicates
nondeterm member(integer, list) % проверяет, является ли элемент членом списка
nondeterm rep(list, list) %создание дополнительного аргумента правила
nondeterm repeated_elements(list, list, list)

clauses
member(X, [X|T]). % рекурсия проходит весь список и выходит с положительным ответом, если есть совпадение
member(X, [Y|T]):-
member(X, T).
rep(List, Repeated):- %создание дополнительного пустого списка для временного хранения повторяющегося элемента
repeated_elements(List, [], Repeated).
repeated_elements([], Repeated, Repeated):-!. % исходный случай, когда заданный список пуст
repeated_elements([H|T], Buf, Repeated):- % берется элемент списка
member(H, T), % проверяется, есть ли элемент в хвосте
NOT(member(H, Buf)), !, % проверяется, нет ли элемента в буфере
repeated_elements(T, [H|Buf], Repeated). % тогда элемент записывается в буфер
repeated_elements([H|T], Buf, Repeated):- % иначе переход на следующий шаг рекурсии
repeated_elements(T, Buf, Repeated).
goal
rep([0, 1, 2, 3, 4, -5, 1, 7, 5, 6, 6, 0], X).