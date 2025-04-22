% --- Set Operations in Prolog ---

% Helper: Remove duplicates from a list to ensure set-like behavior
remove_duplicates([], []).
remove_duplicates([H|T], R) :- member(H, T), remove_duplicates(T, R).
remove_duplicates([H|T], [H|R]) :- \+ member(H, T), remove_duplicates(T, R).

% --- Union of Two Sets ---
% Returns a set containing all unique elements from both lists
union_set(A, B, Union) :-
    append(A, B, Temp),
    remove_duplicates(Temp, Union).

% --- Intersection of Two Sets ---
% Returns a set of elements common to both lists
intersection_set([], _, []).
intersection_set([H|T], B, [H|R]) :- member(H, B), intersection_set(T, B, R).
intersection_set([H|T], B, R) :- \+ member(H, B), intersection_set(T, B, R).

% --- Complement ---
% Returns elements in A that are not in B
complement_set([], _, []).
complement_set([H|T], B, [H|R]) :- \+ member(H, B), complement_set(T, B, R).
complement_set([H|T], B, R) :- member(H, B), complement_set(T, B, R).