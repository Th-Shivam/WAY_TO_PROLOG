% Facts
parent(ram, shyam).
parent(ram, sita).
parent(shyam, mohan).
parent(sita, radha).

male(ram).
male(shyam).
male(mohan).

female(sita).
female(radha).

% Rules
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- grandparent(X, Y), male(X).
grandmother(X, Y) :- grandparent(X, Y), female(X).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
child(X, Y) :- parent(Y, X).
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% Utility: Validate person exists
valid_person(P) :- male(P); female(P).

% Safe query wrapper
safe_query(Query) :- 
    term_variables(Query, Vars),
    (   maplist(valid_person, Vars) -> 
        call(Query)
    ;   write('Error: Unknown person in query'), nl, fail
    ).