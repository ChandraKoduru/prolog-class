max(X,Y,X) :- X >= Y,!.
max(X,Y,Y) :- X < Y.

max1(X,Y,Max) :- X >= Y, !, Max = X; Max = Y.
