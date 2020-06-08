:- module(set_operations,
    [contains/2,
    doesnot_contain/2,
    union/3,
    difference/3]).

include_item(I, Items, [I|ItemsAfterExclusion]):-
    de_duplicate(Items, ItemsAfterDeDup),
    exclude_item(I, ItemsAfterDeDup, ItemsAfterExclusion).

%NOTE: there can only one item atmost that is equal
exclude_item(_, [], []):-!.
exclude_item(I, [I|T], R):-
    nonvar(I),
    !,
    exclude_item(I, T, R).
exclude_item(I, [H|T], [H|Ex]):-
    nonvar(I),
    exclude_item(I, T, Ex).

de_duplicate([], []).
de_duplicate([H1|T1], [H1|DDT]):-
    exclude_item(H1, T1, AfterExclusion),
    de_duplicate(AfterExclusion, DDT).

include_items(SrcItems, DestItems, ItemsAfterInclusion):-
    append(SrcItems, DestItems, AllItems),
    de_duplicate(AllItems, ItemsAfterInclusion).

identical_sets([], []).
identical_sets(S1, S2):-
    exclude_items(S1, S2, []),
    exclude_items(S2, S1, []).

exclude_items([], DestItems, ItemsAfterExclusion):-
    de_duplicate(DestItems, ItemsAfterExclusion).
exclude_items([H|T], DestItems, ItemsAfterExclusion):-
    exclude_item(H, DestItems, ExcludedItems),
    exclude_items(T, ExcludedItems, ItemsAfterExclusion).

% S contains S0
contains(S, S0):-
    include_items(S0, S, O),
    identical_sets(S, O).

test_contains:-
    contains([], []),
    contains([a,b], []),
    contains([a,b], [b,a]),
    contains([b,a], [a,b]),
    contains([b,a,c], [a,b]),
    \+contains([b,a,c], [a,b,d]),
    true.

% S0 doesnot contain any element of S
doesnot_contain(S0, S):-
    exclude_items(S, S0, S1),
    identical_sets(S0, S1).

test_doesnot_contain:-
    doesnot_contain([], []),
    doesnot_contain([], [a]),
    doesnot_contain([b], [a]),
    doesnot_contain([b,a], [c]),
    doesnot_contain([b,a], [d,c]),
    \+ doesnot_contain([b,a], [c,a]),
    true.

union(S0, S1, S):-
    include_items(S0, S1, S).

test_union:-
    union([], [a], [a]),
    union([], [b,a], S1), identical_sets([b,a], S1),
    union([a], [], [a]),
    union([b,a], [], S2), identical_sets([b,a], S2),
    union([b], [a], S3), identical_sets([b,a], S3),
    union([b,a], [a], S4), identical_sets([b,a], S4),
    union([b,a], [a,b], S5),identical_sets([b,a], S5),
    union([c,b,a], [a,b], S6), identical_sets([a,b,c], S6),
    true.

% S = S0 - S1
difference(S0, S1, S):-
    exclude_items(S1, S0, S).

test_difference:-
    difference([a,b,c], [a,b], [c]),
    difference([a,b,c], [b], [a,c]),
    difference([a,b,c], [], [a,b,c]),
    \+ difference([a,b,c], [], [b,a,c]),
    difference([], [b,a,c], []),
    true.

test:-
    test_contains,
    test_doesnot_contain,
    test_union,
    test_difference,
    true.
