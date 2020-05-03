
pattern_index([], _, _):- !,fail.

pattern_index(List, Pattern, Index):-
  append(L1, L2, List),
  length(L1, Index), %not a good name. 
  pattern_match_at(L2, Pattern).

pattern_match_at(_, []):- !.

pattern_match_at([], [_|_]):- !, fail.

pattern_match_at([H|TList], [H|PList]):-
  pattern_match_at(TList, PList), !.

pattern_match_at([H|_], [NonH|_]):- H \= NonH, !, fail.
