p01_last(X, [X]).
p01_last(X, [H|T]) :- p01_last(X, T).

p02_last_but_one(X, [X,Y]).
p02_last_but_one(X, [H|T]):- p02_last_but_one(X,T).

element_at(E,1,[E|T]).
element_at(E,I,[H|T]) :- I >= 2, NK is I - 1, element_at(E, NI, T).
