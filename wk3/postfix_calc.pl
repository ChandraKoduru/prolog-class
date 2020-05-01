postfix(Operations, Result):-
  postfix_(Operations, [], Result).


postfix_(['+'|Operations], [V1,V2|Rest], Result) :-
  Out is V1 + V2,
  postfix_(Operations, [Out|Rest], Result),
  !.

postfix_(['*'|Operations], [V1,V2|Rest], Result) :-
  Out is V1 * V2,
  postfix_(Operations, [Out|Rest], Result),
  !.

postfix_(['-'|Operations], [V1,V2|Rest], Result) :-
  Out is V1 - V2,
  postfix_(Operations, [Out|Rest], Result),
  !.

postfix_(['/'|Operations], [V1,V2|Rest], Result) :-
  Out is V1 / V2,
  postfix_(Operations, [Out|Rest], Result),
  !.

postfix_([N|Operations], Rest, Result):-
  postfix_(Operations, [N|Rest], Result),
  !.

postfix_([], [Result], Result) :- !.
