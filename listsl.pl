/*
Examples of using lists in Prolog
ya existe una función de last. es last([a,b,c], X). y da X=c
*/

%Base case, if I only have a head, my last element is said head. 
tec_last([H|[]], H).

%Recursive case
tec_last([H|T] , L) :-  %PODEMOS USAR _ EN LUGAR DE H PARA DECIR QUE ESA VARIABLE NO NOS IMPORTA. 
	tec_last(T, L).

%base case
tec_length([],L, L).
tec_length([_|T], CURR, L) :-
	L1 is CURR + 1,
	tec_length(T, L1, L).

tec_length([],0).
tec_length([_|T], L) :-
	tec_length(T, L1),
	L is L1 +1.

%Reverse a list
tec_reverse(L, R) :-
	reverse_helper(L, R, []).
reverse_helper([], R, R).

reverse_helper([H|T], R, A) :-
	reverse_helper(T, R, [H|A]).

%Append two lists
tec_append([], L, L).
%Recursive rule
tec_append( [H1|T1], L2, [H1|R]) :-
	tec_append(T1, L2, R).

%Double the elements of a list
double_elements([],[]).

%Recursive rule
double_elements([H|T], [X|R]) :-
	X is H*2,
	double_elements(T, R).

$Flatten a list that may contain other lists
tec_flatten([] , []).

tec_flatten(X,[X]) :-
	%Not is used as not provable.
	\+ is_list(X).

tec_flatten([H|T] , R) :-
	tec_flatten(H,FlatHead),
	tec_flatten(T,FlatTail),
	append(FlatHead,FlatTail,R).