pldoc_wiki:row([A|D], B, F) :-
    user:
    (   cell(A, B, C), !,
	E=C,
	row(D, E, F)
    ).
pldoc_wiki:row([], A, A).

:- dynamic row/4.

row(2, "Name2", "Phone2", "Profession2").
row(1, "Name1", "Phone1", "Profession1").

