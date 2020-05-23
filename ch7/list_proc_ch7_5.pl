last1(X, [X]).
last1(X, [_|T]):- last(X, T).

nextto(X, Y, [X,Y|_]).
nextto(X, Y, [_|T]):- nextto(X, Y, T).

append1([], L, L).
append1([H|L1], L2, [H|L3]):-
    append(L1, L2, L3).

rev([], []).
rev([H|T], R):-
    rev(T, RevT),
    append(RevT, [H], R).

efface(_, [], []).
efface(A, [A|L], L):-!.
efface(A, [B|L], [B|O]):-
    efface(A, L, O).
