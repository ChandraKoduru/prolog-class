% door(connecting_room1, connecting_room2) ==> d(R1, R2)
d(a, b). d(b, a).
d(b, e). d(e, b).
d(b, c). d(c, b).
d(d, e). d(e, d).
d(c, d). d(d, c).
d(e, f). d(f, e).
d(g, e). d(e, g).

hasphone(g).

spaces(N):- N =< 0, !.
spaces(N):-
    format(" "),
    N1 is N - 1,
    spaces(N1).

go(X, X, _, NSpaces):- format("~n"), spaces(NSpaces), format("*").
go(X, Y, T, NSpaces):-
    d(X, Z),
    \+ member(Z, T),
    format("~n"),
    spaces(NSpaces),
    format("~s", [Z]),
    FourMoreSpaces is NSpaces + 4,
    go(Z, Y, [Z|T], FourMoreSpaces).

go(X, Y, T):- go(X, Y, T, 0).

test1:-
    %go to all rooms, if there is phone let us know
    go(a, X, []), hasphone(X),!, format("~nFound telephone is room: ~s", [X]).

test2:-
    % go to all rooms, if there is phone let us know and stop. i.e only one solution
    go(a, X, []), hasphone(X), format("~nFound telephone is room: ~s", [X]).

test3:-
    % first know the rooms that has phone and then look for that room
    hasphone(X), go(a, X, []), format("~nFound telephone is room: ~s", [X]).
