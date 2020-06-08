:- use_module(planner).

action([], [at_shop], [at_shop], [at_home, at_theatre], "Goto Shop").
action([], [at_home], [at_home], [at_shop, at_theatre], "Goto Home").
action([], [at_theatre, watch_movie], [at_theatre], [at_shop, at_home], "Goto Theatre").

action([at_shop], [food_available], [food_available], [], "Buy Food").
action([hungry, food_available, at_home], [], [], [hungry, food_available], "Eat Food").

action([at_theatre], [tickets, watch_movie], [tickets], [], "Buy Tickets").
action([at_theatre, tickets], [hungry, watch_movie], [watch_movie], [tickets], "Watch Movie").

goal([watch_movie], [hungry]).

p1(Actions, L, PlanbActions, L2):-
    InitState = [hungry, at_home],
    length(Actions, L), plan(InitState, Actions),
    length(PlanbActions, L2), phrase(plan_dcg(InitState), PlanbActions).


