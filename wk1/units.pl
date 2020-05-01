
% I wish to play a real time strategy game of the sort with a
% 'tech tree' - you must know how to

exists(peasant).
exists(X) :- seen(X).
exists(X) :- requires(Y, X), exists(Y).

% tank factory is required to build tank
requires(tank, tank_factory).
requires(tank_factory, forging).
requires(tank_factory, steel_mill).
requires(steel_mill, metallurgy).
requires(steel_mill, blacksmith).
requires(metallurgy, philosopher).
requires(forging, blacksmith).
requires(philosopher, peasant).
requires(blacksmith, peasant).

can_build(X) :- exists(X).

seen(steel_mill).
seen(tank).

thing(tank).
thing(tank_factory).
thing(forging).
thing(steel_mill).
thing(metallurgy).
thing(blacksmith).
thing(philosopher).
thing(peasant).
