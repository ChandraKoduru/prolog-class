zero(X):- X<0,!,fail.
zero(0):- writeln(0),!.
zero(X):- writeln(X),NX is X-1,zero(NX).
