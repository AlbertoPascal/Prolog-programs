/*
	Simple example of Natural Language Processing
	Alberto Pascal
	A01023607
	2019/11/04
*/

%%% Vocabulary
article([el]).
article([la]).
noun([niño]).
noun([bici]).
verb([corre]).
verb([monta]).

%%%Rules 
sentence(L) :-
	noun_phrase(NL), 
	verb_phrase(VL), 
	append(NL, VL, L).

noun_phrase(L):-
	article(A), 
	noun(N), 
	append(A, N, L).

verb_phrase(L) :-
	verb(V), 
	append(V, [], L).
verb_phrase(L):-
	verb(V), 
	noun_phrase(N), 
	append(V,N,L).