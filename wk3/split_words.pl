codes_words(String, NonEmptyAlphaWords) :-
  split_string(String, " ", "", Words),
  maplist(strip_non_alpha, Words, AlphaWords),
  exclude(is_empty_string, AlphaWords, NonEmptyAlphaWords).

is_empty_string("").

strip_non_alpha(Word, AlphaWord):-
  string_chars(Word, Chars),
  include(is_alpha, Chars, ValidChars),
  format(atom(AlphaWord), '~s', [ValidChars]).

is_alpha(C) :- char_code(C, CV), 65 =< CV, CV =< 95.
is_alpha(C) :- char_code(C, CV), 97 =< CV, CV =< 122.
