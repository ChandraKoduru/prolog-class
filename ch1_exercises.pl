% 1.a
mother(M, S) :- female(M), parent(M, S).

% 1.b
father(F, S) :- male(F), parent(F, S).

% 1.c
human(H) :- parent(P, H), human(P).

% 1.d
human(H) :- mother(M, H), human(M), father(F, H), human(F).

% 1.e
human(M) :- mother(M, H), human(H).
human(F) :- father(F, H), human(H).

% 1.f
parent(P, P) :- !,false.


% ex: 2
mother(M) :- mother(M, _).
father(F) :- fatehr(F, _).

son(S,P) :- parent(P, S), male(S).
daughter(D,P) :- parent(P, D), female(D).

grandfather(GF, GC) :- male(GF), parent(P, GC), parent(GF, P).
sibling(X, Y) :- parent(P, X), parent(P, Y).

aunt(A, N) :- female(A), parent(P, N), sibling(P, A).

% ex: 3

% hc -> heavenly creature
% wd -> worth discussing
% star -> x i star
% comet -> x is comet
% planet -> x is planet
% near -> X is near y
% ht -> x has a tail

planet(HC) :- \+ star(HC), \+ comet(HC), hc(HC), wd(HC).
star(HC) :- \+ planet(HC), \+ comet(HC), hc(HC), wd(HC).
comet(HC) :- \+ planet(HC), \+ star(HC), hc(HC), wd(HC).

hc(venus).
star(venus) :- false.

ht(C) :- comet(C), near(C, sun).

near(venus, sun).
ht(venus) :- false.

% ex 6

cat(cattie).
human(john).

% bird(X) : X is a bird
% worm(X) : X is a worm
% cat(X) : X is a cat
% fish(X) : X is a fish
% friends(X, Y): X <-> Y are friends to each other
% friend(X, Y): X is friend of Y
% likes(X, Y) : X likes Y
% eats(X, Y) : X eats Y

likes(B, W) :- bird(B), worm(W).
likes(C, F) :- cat(C), fish(F).
likes(X, Y) :- friends(X, Y)
friends(cattie, john).
eats(cattie, Y) : likes(cattie, Y).

% cattie likes fish


