domains
 list=integer*.
 
predicates
 nondeterm fib(list, integer) % создание ряда Фибоначчи в обратном порядке
 nondeterm connect(list, list, list) % объединение списков
 nondeterm reverse(list, list) % реверсия списка
 nondeterm task(integer, list) % объединение операций
 
clauses
 fib([1], 1). % для случая N=1
 fib([1, 1], 2). % для случая N=2 и больше
 fib([P, X1, X2|T], N):- % рекурсивное правило,записывающее в список ряд Фибоначчи от большего 
  N>2, 
  N1=N-1, % N уменьшается,пока не станет равным 2
  fib([X1, X2|T], N1), 
  P=X1+X2. % следующий элемент равен сумме двух предыдущих
 
 connect([], List, List).
 connect([X|List1], List2, [X|List3]):- 
  connect(List1, List2, List3).
 
 reverse([], []).
 reverse([X|T], R):- 
  reverse(T, RT), 
  connect(RT, [X], R).
 
 task(N, Fib) :- 
  fib(Fibr, N), 
  reverse(Fibr, Fib).
goal
 task(10,Fib).
 
