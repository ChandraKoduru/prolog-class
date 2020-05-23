lookup(H, w(H, G, _, _), G1):- !, G = G1.
lookup(H, w(H1, _, Before, _), G):-
    H @< H1,
    lookup(H, Before, G).
lookup(H, w(H1, _, _, After), G):-
    H @>H1,
    lookup(H, After, G).

test(S):-
    lookup(massinga,   S, 10),
    lookup(braemar,    S, 15),
    lookup(nettleweed, S, 25),
    lookup(panorama,   S, 5),
    true.

test2(S):-
    lookup(adela, S, 24),
    lookup(braemar, S, 32),
    lookup(nettleweed, S, 45),
    lookup(massinga, S, 28),
    true.

