% ex 7

% valid(X) :- member(X, [a,b,d]).

dist(a, b, 3).
dist(b, d, 2).
dist(d, e, 4).
dist(e, m, 1).
dist(a, c, 2).
dist(b, e, 3).
distance(X, Y, Z) :- dist(X, Y, Z).
distance(X, Y, Z) :- dist(X, MX, D1), distance(MX, Y, D2), Z is (D1 + D2).
