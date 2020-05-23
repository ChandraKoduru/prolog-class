permutation([], []).
permutation(L, [H|T]):-
    append(V, [H|U], L),
    append(V, U, W),
    permutation(W, T).

sort(L1, L2):-
    permutation(L1, L2),
    sorted(L2),
    !.

sorted([]).
sorted([X]).
sorted([X,Y|Z]):-
    order(X,Y),
    sorted([Y|Z]).

