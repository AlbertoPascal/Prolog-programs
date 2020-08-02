/*
Alberto Pascal
A01023607
Prolog Trees.
*/

% Relations to store predefined trees
test_tree(1, node(6, node(2, nil, node(5, nil, nil)), node(8, nil, nil))).
% Invalid trees
test_tree(2, node(6, node(2, node(5, nil, nil)), node(8, nil, nil))).
test_tree(3, node(45, node(12, node(3, nil, nil), node(23, nil, nil)), node(52, node(48, nil, nil), node(59, nil, nil)))).


%%% Predicate to determine if an expression is a valid tree
% Base case fact
is_tree(nil).
% Recursive calls
is_tree(node(_, LT, RT)) :-
    is_tree(LT),
    is_tree(RT).

%%% Search for an element inside the tree
tree_element(X, node(R, _, _)) :-
    X = R.
tree_element(X, node(R, LT, _)) :-
    X < R,
    tree_element(X, LT).
tree_element(X, node(R, _, RT)) :-
    X > R,
    tree_element(X, RT).

%%% Insert a new element X in the tree. The result is NewTree
% Base case
tree_insert(X, nil, node(X, nil, nil)).
% If the element is already in the tree, do nothing
tree_insert(X, node(R, LT, RT), node(R, LT, RT)) :-
    X = R.
tree_insert(X, node(R, LT, RT), node(R, NLT, RT)) :-
    X < R,
    tree_insert(X, LT, NLT).
tree_insert(X, node(R, LT, RT), node(R, LT, NRT)) :-
    X > R,
    tree_insert(X, RT, NRT).

%%% Convert a tree into an ordered list
tree_inorder(nil, []).
tree_inorder(node(R, LT, RT), L) :-
    tree_inorder(LT, LL),
    tree_inorder(RT, RL),
    append(LL, [R|RL], L).

%%% Print a nicely formatted tree
print_tree(nil, 0, _).
%print_tree(Tree, Depth, Char).


%%% Delete an element from the tree
tree_delete(_, nil, nil).
% Find the element
tree_delete(X, node(R, LT, RT), node(R, NLT, RT)) :-
    X < R,
    tree_delete(X, LT, NLT).
tree_delete(X, node(R, LT, RT), node(R, LT, NRT)) :-
    X > R,
    tree_delete(X, RT, NRT).
% Delete the element found
% Leaf node
tree_delete(X, node(X, nil, nil), nil).
% Only one branch
tree_delete(X, node(X, LT, nil), LT).
tree_delete(X, node(X, nil, RT), RT).
% Two branches
tree_delete(X, node(X, LT, RT), node(Min, LT, NRT)) :-
    tree_min(RT, Min),
    tree_delete(Min, RT, NRT).

% Find the smallest number in a tree
tree_min(nil, nil).
tree_min(node(R, nil, _), R).
tree_min(node(_, LT, _), Min) :-
    tree_min(LT, Min).

%%% Assigned tasks:
%LIST LEAVES
list_leaves(node(_,LT,nil),L):- %When I have only a left node, I will search that sub-tree
    list_leaves(LT, L).
list_leaves(node(_,nil, RT), L):- %When I have only a right node, I will search it too
    list_leaves(RT,L).
list_leaves(node(X,nil,nil), [X]). %if I have only a value and no trees, I am a leaf so I return my value
list_leaves(node(_,LT,RT),L):- %if I have both, I will keep searching for both instances. 
    list_leaves(LT,L2), %first I go to the left trees
    list_leaves(RT,L3), %then I go to the right trees
    append(L2, L3, L). %I return my values appended. 

%TREE-HEIGHT
%I need procedures to compare which side of my tree is the highest.
greater-height(N1,N2,R):- 
    N1>N2,
    R is N1.
greater-height(N1,N2,R):-
    N1<N2,
    R is N2.
greater-height(N1,N2,R):-
    N1=N2,
    R is N1.
%To calculate the tree height starting from 1. 
tree_height(nil,0). %if my tree is nil, my height returns 0. 
tree_height(node(_,nil,nil),1). %if I have at least one node, I return a height of 1. 
tree_height(node(_,LT,RT),R):- %when having more than one node, I calculate each side.
    tree_height(LT, LH), %I will get the height of my left trees
    tree_height(RT, RH), %I will get the heigh of my right trees
    greater-height(LH,RH, RootlessHeight), %my height is the greatest between the two.
    R is RootlessHeight +1. %I add my root node to the obtained height.

%Symmetric tree
%To check if a tree is symmetric means that both, their right tree and left tree are mirrors.
symmetric_tree(node(_,LT,RT)):-
    mirror_tree(LT,RT).
%to validate if I have mirror trees I need to compare their structure.
mirror_tree(nil,nil). %the mirror of a nil is a nil
mirror_tree(node(_,LT,RT),node(_,LT2,RT2)):- %if I have at least one node in both, I compare.
    mirror_tree(LT,RT2), %I will compare the left side of my first tree with the right side of my second tree.
    mirror_tree(RT,LT2). %I will compare the right side of my first tree with the left of the second.
    %if both are the same, I can conclude that my tree is a mirror no matter their values.


%PRINT TREE
%to print my tree I need a function that handles spacing
space_chars(Num):-
    Num>0, %as long as I have at least 1 space to do ( at last one node)
    tab(3), %I will insert 3 spaces for each time I "moved" in my tree.
    space_chars(Num-1). %I "go back" in my tree to handle spaces properly.

%to print trees
print_tree(node(X,LT,RT)):- %when I receive at least one node, I will start the printing.
    print_tree_helper(node(X,LT,RT), -1, '--'). %I send my first char as -- to print the root with that.

print_tree_helper(nil, _, _). %print helper. When I get a nil tree, I return my current char and tabbing
print_tree_helper(node(X, LT, RT), Curr_tab, Curr_char):- %to print in order
   C2 is Curr_tab +1, %First I will add to the tabbing parameter stating I moved to 1 child.
   print_tree_helper(RT, C2, '/-'), %%I will print the right side so the tree must have a /-
   \+ space_chars(C2),  %whenever I finished printing the spacing from this "height" I can continue
   write(Curr_char), % I will write my designed separator. /- for right, \- for left and -- for root.
   write(X), %I will print my element
   nl,%go to a new line
   print_tree_helper(LT, C2, '\\-'). %keep track of the same level but now with my left tree.

list_leaves(node(X,nil,nil), [X]). %if I have only a value and no trees, I am a leaf so I return my value
list_leaves(node(_,LT,RT),L):- %if I have both, I will keep searching for both instances. 
    list_leaves(LT,L2), %first I go to the left trees
    list_leaves(RT,L3), %then I go to the right trees
    append(L2, L3, L). %I return my values appended. 