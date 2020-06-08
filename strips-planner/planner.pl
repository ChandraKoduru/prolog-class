:- module(planner,
    [plan/2, plan_dcg/3]).
:- use_module(set_operations).


state_transition(S0, S, ActionName):-
    action(Prereqs0, NegPreReqs0, Add0, Remove0, ActionName),
    contains(S0, Prereqs0),
    doesnot_contain(S0, NegPreReqs0),
    union(S0, Add0, S1),
    difference(S1, Remove0, S).

plan(CurrentState, [ActionName|NextActions]):-
    (is_goal(CurrentState) ->
        format("~nGoal reached");
        state_transition(CurrentState, NextState, ActionName),
        plan(NextState, NextActions)).

plan_dcg(S0) --> {is_goal(S0), format("~n Goal reached!")}, [].
plan_dcg(S0) --> [ActionName],
            {
                % format("~n S0: ~w", [S0]),
                state_transition(S0, S, ActionName)
                % format("~n Action: ~w, ~w~n", [ActionName, S])
            },
            plan_dcg(S).

is_goal(S):-
    goal(ShouldHold, ShouldNotHold),
    contains(S, ShouldHold),
    doesnot_contain(S, ShouldNotHold).
