/*
Hello world in prolog
Alberto Pascal 
A01023607
*/

%Facts
man(socrates).
man(gil).

%Rules
mortal(X) :- man(X).

%Query
%mortal(socrates).

/*
Prolog can infere. If I query mortal(X), I will get x= socrates and then return true

; -> OR

*/