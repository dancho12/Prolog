DOMAINS  
 namelist = name*
 name = integer
PREDICATES
 nondeterm create_list(namelist,namelist)
 nondeterm create_list2(namelist,namelist,integer,integer)
 nondeterm insertElem(integer,namelist,namelist)
 nondeterm run
 nondeterm go(integer,integer)
 nondeterm do(char) 
CLAUSES
 insertElem(X,L,[X|L]).
 
 create_list(L,NewL):-  readint(C),
 			insertElem(C,L,TempL),
 			create_list(TempL,NewL).
 create_list(L,L).


create_list2(L,NewL,C,Y):-  
 			insertElem(C,L,TempL),
 			NC=C-1,
 			NC>=Y,
 			create_list2(TempL,NewL,NC,Y).
 create_list2(L,L,NX,NX).

 go(X,Y):- 
		X<Y,
		NX=X-1, 
		create_list2([],L,Y,NX),
 write("L=",L).
 go(X,Y):-
 X>Y,
 write("Num1 > Num2. Try agan!!"),nl,
 run.
run :- 

write(" **** Enter **** \n"), 
write(" - 1 - Input\n"), 
write(" - 0 - to EXIT\n"), 
write("**************\n"), 
write(">>"), readchar(X),write(X), nl, 
do(X), 
run. 
do('1'):- 
write("Num1>>"), readint(X), 
write("Num2>>"), readint(Y),
go(X,Y), nl. 
do('0'):-write ("That's all"), exit. 
do('_'):-write ("Try again"). 

GOAL
run.