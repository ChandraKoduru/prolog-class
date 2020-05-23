s(+, X, 0, X).
s(+, 0, X, X).
s(+, X, Y, Z):-
    number(X),
    number(Y),
    Z is X + Y.

s(*, _, 0, 0).
s(*, 0, _, 0).
s(*, X, 1, X).
s(*, 1, X, X).
s(*, X, Y, Z):-
    number(X),
    number(Y),
    Z is X * Y.

simp(E, E):- atomic(E), !.
simp(E, F):-
    E =.. [Op, La, Ra],
    simp(La, X),
    simp(Ra, Y),
    s(Op, X, Y, F).
