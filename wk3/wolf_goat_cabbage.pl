
% state{boat:Bank, wolf:Bank, goat:Bank, cabbage:Bank}.

sample(state{boat:Bank, wolf:Bank, goat:Bank, cabbage:Bank}):- Bank = left.
sample(state{boat:Bank, wolf:Bank, goat:Bank, cabbage:Bank}) :- other_bank(left, Bank).
sample(state{boat:left, wolf:right, goat:right, cabbage:left}).
sample(state{boat:left, wolf:left, goat:right, cabbage:right}).
sample(state{boat:left, wolf:right, goat:right, cabbage:right}).
sample(state{boat:left, wolf:right, goat:left, cabbage:right}).
sample(state{boat:left, wolf:left, goat:left, cabbage:right}).
sample(state{boat:right, wolf:left, goat:right, cabbage:right}).


wgc(Moves):-
  StartBank = left,
  other_bank(StartBank, OtherBank),
  Start = state{boat:StartBank, wolf:StartBank, goat:StartBank, cabbage:StartBank},
  End = state{boat:OtherBank, wolf:OtherBank, goat:OtherBank, cabbage:OtherBank},
  plan_moves(End, [Start], Moves).

plan_moves(End, [Latest|Previous], [Latest|Previous]) :-
  is_same_state(End, Latest), !.

plan_moves(End, CurrentMoves, Moves):-
  next_state(CurrentMoves, NextMove),
  plan_moves(End, [NextMove|CurrentMoves], Moves).

next_state([CurrentState|PreviousStates], NextState) :-
  next_possible_state(CurrentState, NextState),
  is_valid_state(NextState),
  is_not_one_of_previous_states(NextState, PreviousStates)
  .

next_possible_state(S,NS) :- only_farmer(S, NS).
next_possible_state(S,NS) :- with_cabbage(S, NS).
next_possible_state(S,NS) :- with_goat(S, NS).
next_possible_state(S,NS) :- with_wolf(S, NS).

only_farmer(state{boat:B, wolf:W, goat:G, cabbage:C},
  state{boat:BN, wolf:W, goat:G, cabbage:C}):-
    other_bank(B, BN).

with_wolf(state{boat:B, wolf:B, goat:G, cabbage:C},
  state{boat:BN, wolf:BN, goat:G, cabbage:C}):-
    other_bank(B, BN).

with_goat(state{boat:B, wolf:W, goat:B, cabbage:C},
  state{boat:BN, wolf:W, goat:BN, cabbage:C}):-
    other_bank(B, BN).

with_cabbage(state{boat:B, wolf:W, goat:G, cabbage:B},
  state{boat:BN, wolf:W, goat:G, cabbage:BN}):-
    other_bank(B, BN).

other_bank(left, right).
other_bank(right, left).

is_invalid_state(state{boat:NotB, wolf:B, goat:B, cabbage:_}) :- B \= NotB, !.
is_invalid_state(state{boat:NotB, wolf:_, goat:B, cabbage:B}) :- B \= NotB, !.

is_valid_state(S):- \+ is_invalid_state(S).

is_one_of_previous_states(_, []) :- false, !.
is_one_of_previous_states(S1, [S2|_]) :- is_same_state(S1, S2), !.
is_one_of_previous_states(State, [_|Rest]) :-
  is_one_of_previous_states(State, Rest).

is_not_one_of_previous_states(State, PreviousStates) :-
  \+ is_one_of_previous_states(State, PreviousStates).

is_same_state(state{boat:B, wolf:W, goat:G, cabbage:C},
              state{boat:B, wolf:W, goat:G, cabbage:C}).

print_states(SS):-
  maplist(print_state, SS).

print_state(state{boat:B, wolf:W, goat:G, cabbage:C}):-
  LT0 = [],
  RT0 = [],
  allot_wolf(W, LT0, RT0, LT1, RT1),
  allot_goat(G, LT1, RT1, LT2, RT2),
  allot_cabbage(C, LT2, RT2, LT3, RT3),
  allot_boat(B, LT3, RT3, LT4, RT4),
  format('~n~w  ----  ~w', [LT4, RT4]).

allot_boat(Bank, LB, RB, NLB, NRB):-
  allot_with_symbol(boat, Bank, LB, RB, NLB, NRB).

allot_wolf(Bank, LB, RB, NLB, NRB):-
  allot_with_symbol(wolf, Bank, LB, RB, NLB, NRB).

allot_goat(Bank, LB, RB, NLB, NRB):-
  allot_with_symbol(goat, Bank, LB, RB, NLB, NRB).

allot_cabbage(Bank, LB, RB, NLB, NRB):-
  allot_with_symbol(cabbage, Bank, LB, RB, NLB, NRB).

allot_with_symbol(Symbol, Bank, LB, RB, NLB, NRB):-
  (is_left_bank(Bank) -> NLB = [Symbol|LB], NRB=RB; NLB = LB, NRB=[Symbol|RB]).

is_left_bank(left).
