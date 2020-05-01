area_code(AreaCode, Number) :-
  999999999 < Number , Number =< 9999999999,
  AreaCode is div(Number, 10000000).
