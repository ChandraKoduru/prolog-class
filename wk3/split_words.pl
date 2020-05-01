code_words(String, AlphaWords) :-
  split_string(String, " ", "", Words),
  code_words_(Words, AllAlphaWords),
  exclude(is_empty_string, AllAlphaWords, AlphaWords).

strip_non_alpha(Word, NonAlphaWord):-
  string_chars(Word, Chars),
  include(is_alpha, Chars, ValidChars),
  format(atom(NonAlphaWord), '~s', [ValidChars]).

is_empty_string(S) :- string_length(S, L), L == 0.

is_alpha(C) :- char_code(C, CV), 65 =< CV, CV =< 95.
is_alpha(C) :- char_code(C, CV), 97 =< CV, CV =< 122.

code_words_([],[]).
code_words_([FirstWord|Others], [FirstAlphaWord|OtherAlphaWords]) :-
  strip_non_alpha(FirstWord, FirstAlphaWord),
  code_words_(Others, OtherAlphaWords).
