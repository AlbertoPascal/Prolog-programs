
% Facts
father(goku, gohan).
father(goku, goten).
father(bardock, goku).
father(bardock, raditz).
father(vegeta, trunks).
father(vegeta, bulla).
mother(gine, goku).
mother(gine, raditz).
mother(chichi, gohan).
mother(chichi, goten).
mother(bulma, trunks).
mother(bulma, bulla).
male(bardock).
male(goku).
male(vegeta).
male(gohan).
male(goten).
male(trunks).
male(raditz).
female(gine).
female(chichi).
female(bulma).
female(bulla).

%Rules
brothers(X,Y) :-
	father(Z,X) , % , es and
	father(Z,Y) ,
	mother(W,X) , 
	mother(W,Y),
	X \= Y. % \= es diferente

brother(X,Y) :-
	brothers(X,Y),
	male(X).

sister(X,Y) :-
	brothers(X,Y),
	femaile(X).

grandfather(X,Y) :-
	male(X),
	father(Z,Y),
	father(X,Z).

grandmother(X,Y) :-
	female(X),
	mother(Z,Y),
	mother(X,Z).

grandchild(X,Y) :-
	(grandfather(Y,X);
	grandmother(Y,X)).

grandson(X,Y) :-
	grandchild(X,Y),
	male(X).

granddaughter(X,Y) :-
	grandchild(X,Y),
	female(X).

	/*
	Nota: si yo escribo en el compilador brothers(X,Y). me puede dar todas las opciones posibles. para esto encesito poner ; en lugar de enter cada que sale una opción
	El comabdo trace me activa el modo para ver cómo se fue evaluando todo.
	*/