react([flubber, goo], [icky_stuff]).
react([gummy_goo, icky_stuff], [smelly_stuff]).
react([ick, sooty_stuff], [icky_stuff]).
react([smelly_stuff, goo], [icky_stuff]).

reactants_results([], []).
reactants_results([E], [E]) :- !.
reactants_results([C1,C2], Out) :- react([C1,C2], Out),!.
reactants_results([C1,C2], Out) :- react([C2,C1], Out),!. % they may react if in reverse
reactants_results([C1,C2], [C1,C2]) :- !. %C1 and C2 don't react

reactants_results([C1,C2|RestOfChemicals], ReactionResult):-
  reactants_results([C1,C2], Result),
  [C1, C2] \= Result -> % reaction happened
    append(Result, RestOfChemicals, NewPoolOfChemicals),
    reactants_results(NewPoolOfChemicals, ReactionResult);
    reactants_results([C2|RestOfChemicals], ResultsWithC2),
    reactants_results([C1|ResultsWithC2], ReactionResult).


/*
unique([], []).
unique([H], [H]).
unique([H1,H1|T], Out):- !, unique([H1|T], Out).
unique([H1,H2|T], [H1|Out]):- unique([H2|T], Out).
*/

are_same_lists([],[]).
are_same_lists([H1|T1], [H1|T2]) :- are_same_lists(T1, T2).

make_pairs([],[]).
make_pairs([_],_):- !, fail.
make_pairs([F,S], [[F,S]]):- !.

make_pairs([H|T], Pairs):-
  length(T, TLen),
  duplicate(H, TLen, Dupes),
  zip_lists(Dupes, T, Set1),
  make_pairs(T, Set2),
  append(Set1, Set2, Pairs).


zip_lists(L1, L2, Out):-
  maplist(as_list, L1, L2, Out).

as_list(E1, E2, [E1, E2]).

duplicate(_, 0, []):- !.
duplicate(H, N, [H|Rest]):- 0 < N, !, R is N-1, duplicate(H, R, Rest).

rsample([gummy_goo, flubber, goo, goo]).
rsample([flubber, goo]).
rsample([flubber, goo, gummy_goo]).
rsample([flubber, goo, gummy_goo, icky_stuff]).
rsample([flubber, adin, adin, goo, gummy_goo]).
