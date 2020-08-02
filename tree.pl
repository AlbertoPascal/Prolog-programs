
test_tree(1, node(6, node(2, nil, node(5, nil, nil)), node(8, nil, nil))).

is_tree(nil).
is_tree(node(_,LT, RT)) :-
	is_tree(LT), 
	is_tree(RT).

% Predicate to determine if an expresion is a valid tree. 
%Base case:
tree_element(X, node(R, _,_)):-
	X = R.
tree_element(X, node(R, _, RT)):-
	X > R, 
	tree_element(X, RT).
tree_element(X, node(R, LT, _)):-
	X < R, 
	tree_element(X, LT).

tree_insert(X, nil, node(X, nul, nil)).

tree_insert(X, node(R, LT, RT), node(R, NLT, RT)):-
		X<R, 
		tree_insert(X, LT, NLT).

tree_insert(X, node(R, LT, RT), node(R, LT, NRT)):-
		X>R, 
		tree_insert(X, RT, NRT).
tree_insert(X, node(R, LT, RT), node(R, LT, RT)):-
		X=R.

tree_inorder(nil, []).
tree_inorder(node(R, LT, RT), L):-
	tree_inorder(LT,LL),
	tree_inorder(RT,rL),
	append(LL, [R|RL], L).

print_tree(node(R, nil, nil), Depth):- % work in progress.
	tab(Depth),
	write('/'),
	write(R).

print_tree(node(R, LT, RT), Depth):-
	Depth2 is Depth + 1,
	print_tree(RT,Depth2),
	write(R),
	print_tree(LT,Depth2).

tree_delete(_,nil,nil).
tree_delete(X, node(R,LT, RT), node(R, NLT, RT)) :-
	X<R,
	tree_delete(X, LT, NLT).
tree_delete(X, node(R,LT, RT), node(R, LT, NRT)) :-
	X>R,
	tree_delete(X, LT, NRT).
tree_delete(X, node(X, nil, nil), nil).
tree_delete(X, node(X,LT, nil), LT).
tree_delete(X, node(X,nil, RT), RT).
tree_delete(X, node(X,LT, RT),node(Min, LT,NRT)):-
	tree_min(RT, Min), 
	tree_delete(Min, RT, NRT).

tree_min(nil,nil).
tree_min(node(R, nil, _), R).
tree_min(node(R, LT, RT),Min):-
	tree_min(LT,Min).

