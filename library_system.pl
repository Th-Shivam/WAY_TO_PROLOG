# CODE - 3 

% Facts
book('Introduction to AI', 101, available).
book('Machine Learning Basics', 102, available).
book('Prolog Programming', 103, issued).

% Rules
is_available(BookName) :-
    book(BookName, _, available).

issue_book(BookName) :-
    book(BookName, ID, available),
    retract(book(BookName, ID, available)),
    assert(book(BookName, ID, issued)).

return_book(BookName) :-
    book(BookName, ID, issued),
    retract(book(BookName, ID, issued)),
    assert(book(BookName, ID, available)).
