
swap("8cD",   "😀" ).
swap("=8cO",  "😮" ).
swap(";-)",   "😉" ).
swap("X-P",   "🤪").

emoticon_emoji(In, Out):-
  findall(K-V, swap(K, V), SwapPaternsAsListOfKeyValuePairs),
  foldl(replace_all, SwapPaternsAsListOfKeyValuePairs, In, Out).

replace_all(Pattern-Replacement, In, Out):-
  replace_all(Pattern, Replacement, In, Out).

% all occurances of Pattern in In(String) with Replacement resulting Out(String)
% all parameters are strings
replace_all(Pattern, Replacement, In, Out):-
  string(Pattern),string(Replacement),string(In),!,
  atom_string(PatternAsAtom, Pattern),
  atom_string(ReplacementAsAtom, Replacement),
  atom_string(InAsAtom, In),
  replace_all(PatternAsAtom, ReplacementAsAtom, InAsAtom, OutAsAtom),
  atom_string(OutAsAtom, Out).

% all occurances of Pattern, in In(Atom), with Replacement in Out(Atom)
% all parameters are atoms
replace_all(Pattern, Replacement, In, Out):-
  atom(Pattern), atom(Replacement), atom(In), !,
  replace_first_(Pattern, Replacement, In, AfterFirst),
  (In \= AfterFirst ->
      replace_all(Pattern, Replacement, AfterFirst, Out);
      Out = In).

replace_first_(Pattern, Replacement, In, Out):-
  atom(Pattern), atom(Replacement), atom(In),
  prefix_and_suffix(In, Pattern, Prefix, Suffix) ->
    atom_concat(Prefix, Replacement, T),
    atom_concat(T, Suffix, Out);
    Out = In.

prefix_and_suffix(Atom, Pattern, Prefix, Suffix):-
  atom_length(Pattern, PatternLength),
  sub_atom(Atom, U, PatternLength, A, Pattern),
  T is A + PatternLength,
  sub_atom(Atom, U, T, _, Rest),
  atom_concat(Prefix, Rest, Atom),
  atom_concat(Pattern, Suffix, Rest).

esample("hello there 8cD, I'm Anni, 8cD,yoyo").

test_emoticon_emoji:-
  replace_all(c, xy, abcdefghcdefg, abxydefghxydefg),
  replace_all("c", "xy", "abcdefghcdefg", "abxydefghxydefg"),
  emoticon_emoji("hello there 8cD, I'm Annie", "hello there 😀, I'm Annie"),
  emoticon_emoji("wow, that's crazy X-P =8cO", "wow, that's crazy 🤪 😮"),
  true. % keep it last
