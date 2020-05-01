% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

reigns(rhodri, 844, 878).
reigns(anarawd, 878, 916).
reigns(hywel_dda, 916, 950).
reigns(lago_ap_idwal,950,979).
reigns(hywel_ap_ieuaf, 979,985).
reigns(cadwallon,985, 986).
reigns(maredudd, 986,999).

prince(K,Y) :-
    reigns(K, P1, P2),
    P1  =< Y,
    Y =< P2.

