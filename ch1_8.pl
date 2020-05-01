% assume: empty, head, tail
% empty(X).
% head(x, H).
% tail(x, T).

memberx(_, []) :- false,!.
memberx(M, [M|_]).
memberx(M, [_|T]) :- memberx(M, T).

subset([], _).
subset(_, []) :- false.
subset([H|T], L) :- memberx(H, L), drop(H, L, L1), !, subset(T, L1).

drop(_, [], []).
drop(E, [E|T], T).
drop(E, [H|T], [H|T1]) :- drop(E, T, T1).

sum([], 0).
sum([H|T], Total) :- sum(T, SubTotal), Total is H + SubTotal.
