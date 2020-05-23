:- [list_proc_ch7_5].

a(newcastle, carlisle, 58).
a(carlisle, penrith, 23).
a(darlington, newcastle, 40).
a(penrith, darlington, 52).
a(workington, carlisle, 33).
a(workington, penrith, 39).

a(X, Y):- a(X, Y, _).

legal(_, []).
legal(X, [H|T]):-
    \+ X = H,
    legal(X, T).

/* go(X, X, _).
go(X, Y, T):-
    (a(X, Z); a(Z, X)),
        legal(Z, T),
        go(Z, Y, [Z|T]).
 */
go(Start, Dest, Route):-
    go0(Start, Dest, [], R),
    rev(R, Route).

go0(X, X, T, [X|T]).
go0(Place, Y, T, R):-
    legalnode(Place, T, Next),
    go0(Next, Y, [Place|T], R).

legalnode(X, Trail, Y):-
    (a(X, Y); a(Y, X)),
    legal(Y, Trail).

gobfs(Start, Dest, Route):-
    go1([[Start]], Dest, R),
    rev(R, Route).

go1([First|Rest], Dest, First):- First = [Dest|_].
go1([[Last|Trail]|Others], Dest, Route):-
    findall([Z, Last|Trail], legalnode(Last, Trail, Z), List),
    append(List, Others, NewRoutes),
    go1(NewRoutes, Dest, Route).

test:-
    go(darlington, workington, X),
    format("~nRoute: ~w", [X]).
