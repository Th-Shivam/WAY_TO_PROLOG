# CODE - 2 

% Union of two sets
union([], L, L).
union([H|T], L, R) :- member(H, L), union(T, L, R).
union([H|T], L, [H|R]) :- \+ member(H, L), union(T, L, R).

% Intersection of two sets
intersection([], _, []).
intersection([H|T], L, [H|R]) :- member(H, L), intersection(T, L, R).
intersection([H|T], L, R) :- \+ member(H, L), intersection(T, L, R).

% Complement (Elements of First List not in Second)
complement([], _, []).
complement([H|T], L, [H|R]) :- \+ member(H, L), complement(T, L, R).
complement([H|T], L, R) :- member(H, L), complement(T, L, R).
