:- dynamic seed/1.
:- dynamic current_num/2.
:- dynamic found/1.

seed(13).

random(R, N):-
    seed(S),
    N is (S mod R) + 1,
    retract(seed(S)),
    NewSeed is (125 * S + 1) mod 4096,
    asserta(seed(NewSeed)),!.

samples:-
    repeat, random(10, X), write(X), nl, X = 5.

gensym1(Root, Atom):-
    get_num(Root, Num),
    atom_chars(Root, Name1),
    number_chars(Num, Name2),
    append(Name1, Name2, Name),
    atom_chars(Atom, Name).

get_num(Root, Num):-
    retract(current_num(Root, Num1)), !,
    Num is Num1 + 1,
    asserta(current_num(Root, Num)).

get_num(Root, 1):-
    asserta(current_num(Root, 1)).

% findall

findall1(X, G, _):-
    assert(found(mark)),
    call(G),
    assert(found(result(X))),
    fail.

findall1(_, _, L):- collect_found([], M), !, L = M.

collect_found(S, L):-
    getnext(X),
    !,
    collect_found([X|S], L).

collect_found(L, L).

getnext(Y):- retract(found(X)), !, X = result(Y).
