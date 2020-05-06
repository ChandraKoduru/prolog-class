/**
 * Module 3 exercise
 * A version of library predicate sub_term/2
 * my_sub_term/2 succeeds for every term that is part of Term.
 * A few simplifications: consider only numbers, atoms, complex terms, and lists. Ignore cyclic terms (not covered).
 **/

my_sub_term(X, X):- atom(X).
my_sub_term(X, X):- number(X).
my_sub_term(X, X):- is_list(X).
my_sub_term(X, X):- \+ is_list(X), compound(X).

my_sub_term([H|_], S):-
    my_sub_term(H, S).

my_sub_term([_|T], S):-
    my_sub_term(T, S).

my_sub_term(CT, ST):-
    \+ is_list(CT),
    compound(CT),
    CT =.. [_|ListOfTerms],
    compound_sub_terms(ListOfTerms, ST).

compound_sub_terms([], _):- fail.
compound_sub_terms([H|_], S):-
    my_sub_term(H, S).
compound_sub_terms([_|T], S):-
    compound_sub_terms(T, S).

test_my_sub_term:-
    my_sub_term([1], [1]),
    my_sub_term([1,2,foo(3)], 3),
    my_sub_term([1,2,foo(3)], [2,foo(3)]),
    my_sub_term(blah(blarg(foo, mep), [3,4,5], '8cD'), mep),
    \+ my_sub_term(blah(blarg(foo, mep), [3,4,5], '8cD'), blarg(mep)),
    true.
