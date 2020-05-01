zoo(X).
animal(A).
lives(A, Z).
happy(X).
dragon(X).
people(X).
meet(X, Y).
visit(X, zoo(_)).
kind(P).
dragon(X).

animal(A) :- dragon(A).

happy(Animal) :- dragon(Animal), lives(Animal, Z), false.
happy(Animal) :- kind(People), meet(Animal, People).
kind(People) :- visit(People, Z)
lives(Animal, Z) :- animal(Animal), zoo(Z).
meet(Animal, People) :- lives(Animal, Z), visit(People, Z).
