#CODE - 1 

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
