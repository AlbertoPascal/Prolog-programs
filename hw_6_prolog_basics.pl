/*
Alberto Pascal
A01023607
Prolog Basics
2019/10/20
*/
%Rules
has_no_elements([]).
odd([x]).
even([]).


%To calculate the odd length I need to alternate between if its odd or even. 
odd_length([]):-
	\+ even([]). %If I run out of elements when it was odd's turn I can say it is odd. 
odd_length([_|T]):-
	even_length(T).

even_length([]):-
	even([]). %If I run out of elements when it's even's turn, I say it is not odd.
even_length([_|T]):-
	odd_length(T).

%This will check whether my element is in the list or not. 
in_list([H|T], E):- %Main call. This will call my recursive procedure
	\+ in_list_helper([H|T], E). %Since this is a negated logic, I need to return the opposite of what I calculate
%Base case: if my list is empty, I know I have no elements and return true. 
in_list_helper([], _):- 
		has_no_elements([]).
%Recursive case: if I have elements, I check if it is in my list.
in_list_helper([H|T], E):-
	H\=E, %if my element is different, I will continue searching.
	in_list_helper(T, E). %remove the already checked element from the list and continue.

%This returns both, the result, and false. 
nth_element(0,[H|_], H). %when my index reaches 0, I'm standing on the desired element.
nth_element(I, [_|T], R):-
	I2 is I -1, %I will move this element in my index.
	I2>=0,
	nth_element(I2,T, R). %update my index, send new array and continue
	
%This function will return whether or not the lists are the same but in a different order.
is_permutation([H|T], L2):-
	get_length([H|T], Len1), %I get the length of list 1
	get_length(L2, Len2), %I get the length of list 2
	Len1=:=Len2, %If the lists are not the same length, they are not permutations 
	is_permutation_helper([H|T], L2). %If they are, I check each of their elements.

%Base Case: when my first list is empty, I finished iterating.
is_permutation_helper([], _).
%Recursive case:. While I have elements on my first list, I will search for them in my second list
is_permutation_helper([H|T], L2):-
	in_list(L2,H), %If my element is in the list, I can continue. Otherwise, it's false.
	is_permutation_helper(T,L2).


%This function will remove contiguous duplicate elements from a list

%Base Case 1: if I call this with only an element, I should go directly to the recursive base case to prevent erros.
remove_doubles([H], R):-
	remove_doubles_helper([H], [], R).
%Recursive case call: if I have at least two elements, I call the procedure normally.
remove_doubles([H1, H2|T], R):-
	remove_doubles_helper([H1, H2|T], [], R). %This method will be the recursive call

%Base case: I know I have finished when I finished going though my array.
remove_doubles_helper([H], Curr, Newlist):- % last element, return my progress.
		append(Curr,[H], Newlist).
%Recursive case:
%If my element is not in my new list already, I shall add it
remove_doubles_helper([H1, H2|T], Curr, R):-
	H1\=H2, %if first element is different that secondone, it means they are not continuous dupes so I add the first element.
	append(Curr, [H1], Newlist), %I add that element to my list.
	remove_doubles_helper([H2|T], Newlist, R). %Continue checking from the second on. 

%If my element is already on my new list, I shall not add it.
remove_doubles_helper([H1, H2|T], Curr, R):-
	H1=:=H2, %if my element is equal, I need to remove a dupe.
	remove_doubles_helper([H2|T], Curr, R). %Therefore, I don't add it and continue.

/*
	Note: the following functions were not requested but are useful for the implementation or as an extra functionality.
	These include the length calculation and the removal of ALL duplicated values from a list, instead of contiguous only.
*/
%This function will return the length of a given list.
get_length([], 0).
get_length([_|T], L):-
	get_length(T, L2), 
	L is L2 +1.

%This function will remove all duplicate elements from a list
remove_all_duplicates([H|T], R):-
	remove_all_duplicates_helper([H|T], [], R). %This method will be the recursive call

%Base case: I know I have finished when I finished going though my array.
remove_all_duplicates_helper([], Curr, Curr). % last element, return my progress.

%Recursive case:
%If my element is not in my new list already, I shall add it
remove_all_duplicates_helper([H|T], Curr, R):-
	\+ in_list(Curr,H),
	append(Curr, [H], Newlist), 
	remove_all_duplicates_helper(T, Newlist, R).

%If my element is already on my new list, I shall not add it.
remove_all_duplicates_helper([H|T], Curr, R):-
	in_list(Curr,H), 
	remove_all_duplicates_helper(T, Curr, R).

