domains

list=integer*.

predicates

nondeterm sum1(list, integer) % сумма для списка с четным количеством элементов
nondeterm sum2(list, integer) % сумма для списка с нечетным количеством элементов
nondeterm task(list, integer) % выбор предиката
nondeterm length(list, integer) % подсчет длины списка для определения четности количества элементов
nondeterm run
nondeterm do(char)

clauses

length([], 0).
length([X|T], L):- % список уменьшается по одному элементу,пока не станет пустым
length(T, L1),
L=L1+1. % возвращает значение длины списка
sum1([], 0). % исходный случай, список пустой
sum1([X1, X2|List1], Y):-
sum1(List1, Y1),
Y=Y1+X2. % будут складываться второй, четвертый и тд элементы
sum2([_],Y):- % отдельно рассматривается случай со списком из одного элемента,тк нет элемента X2
Y=0.

sum2([], 0). % исходный случай, список пустой

sum2([X1, X2|List1], Y):-

sum2(List1, Y1),

Y=Y1+X1. % будут складываться первый, третий и тд элементы

task(List, Y):-

length(List, L), % получение значения длины списка

L mod 2=0, % проверяется, что остаток от деления на 2 равен 0

sum1(List, Y).

task(List, Y):-

length(List, L), % получение значения длины списка

L mod 2=1, % проверяется, что остаток от деления на 2 равен 0

sum2(List, Y).

run :- 

write(" **** Enter **** \n"), 
write(" - 1 - Start\n"), 
write(" - 0 - to EXIT\n"), 
write("**************\n"), 
write(">>"), readchar(X),write(X), nl, 
do(X), 
run. 
do('1'):- 

readList([H|T]) :-
		write("Add element: "),
		readint(H), % читаем число и помещаем его в голову
		readList(T). % запускаем себя для хвоста
	
	% если введено не число – прекращаем рекурсию, возвращаем пустой список
	readList([]).
task(H, Y).
%% task([1, 0, 0, 1, 1, 2, 3, 4], Y).
do('0'):-write ("That's all"), exit. 
do('_'):-write ("Try again").

goal
run.
%% task([1, 0, 0, 1, 1, 2, 3, 4], Y).