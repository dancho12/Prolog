Predicates

Nondeterm nok(real,real,real,real)
nondeterm run 
nondeterm do(char) 

Clauses

nok(OX,OY,X,Y):-%если второе число меньше первого, то прибавляем к первому числу изначальное второе число
OX>OY, NY = OY + Y, nok(OX,NY,X,Y).

nok(OX,OY,X,Y):-%если первое число меньше второго, то к первому числу прибавляется первое изначальное число
OX<OY, NX = OX + X, nok(NX,Y,X,Y).

nok(OX,OY,_,_):-%когда они равны, то выводится число
OX=OY, write("NOK = ",OX),nl.

run:- %меню выбора
nl, 
write("***Enter***\n\n"), 
write("- 1 - to start counter\n\n"), 
write("- 0 - to EXIT\n\n"), 
write("**************************\n"), 
readchar(X),
do(X).

do('1'):-%ввод чисел
write("Write first number\n"),
write(">>"), readreal(X),nl,
write("Write second number\n"),
write(">>"), readreal(Y), nl,
nok(X,Y,X,Y),
run.

do('0'):- write(" - That`s all."), exit. 

do(_):- write("bad value\n\n"). 

goal run.
