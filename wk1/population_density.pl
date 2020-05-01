pop(usa, 203).
pop(india, 548).
pop(china, 800).
pop(brazil,108).

area(usa, 3).
area(india, 1).
area(china,4).
area(brazil,3).

density(C, PD) :-
    pop(C, P),
    area(C, A),
    PD is P / A.
