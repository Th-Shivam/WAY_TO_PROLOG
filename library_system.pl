% CODE - 3 ENHANCED

% --- Facts ---

% book(Title, BookID, Status).
book('Introduction to AI', 101, available).
book('Machine Learning Basics', 102, available).
book('Prolog Programming', 103, issued).

% user(UserName, UserID).
user('Alice', 1).
user('Bob', 2).

% issued_to(BookID, UserID).
% (Initially empty)

% --- Rules ---

% Check if a book is available
is_available(BookName) :-
    book(BookName, _, available).

% Check if a book is issued
is_issued(BookName) :-
    book(BookName, _, issued).

% Issue a book to a user
issue_book(BookName, UserName) :-
    user(UserName, UserID),
    book(BookName, BookID, available),
    retract(book(BookName, BookID, available)),
    assert(book(BookName, BookID, issued)),
    assert(issued_to(BookID, UserID)),
    format('Book "~w" issued to ~w.~n', [BookName, UserName]).

% Handle invalid issuing attempts
issue_book(BookName, _) :-
    book(BookName, _, issued),
    format('Cannot issue "~w": already issued.~n', [BookName]),
    !.

issue_book(BookName, _) :-
    \+ book(BookName, _, _),
    format('Cannot issue "~w": book not found.~n', [BookName]),
    !.

% Return a book
return_book(BookName) :-
    book(BookName, BookID, issued),
    issued_to(BookID, UserID),
    retract(book(BookName, BookID, issued)),
    assert(book(BookName, BookID, available)),
    retract(issued_to(BookID, UserID)),
    format('Book "~w" returned successfully.~n', [BookName]).

% Handle invalid return attempts
return_book(BookName) :-
    book(BookName, _, available),
    format('Cannot return "~w": book is not issued.~n', [BookName]),
    !.

return_book(BookName) :-
    \+ book(BookName, _, _),
    format('Cannot return "~w": book not found.~n', [BookName]),
    !.

% List all available books
list_available_books :-
    findall(BookName, book(BookName, _, available), AvailableBooks),
    (   AvailableBooks \= []
    ->  format('Available Books: ~w~n', [AvailableBooks])
    ;   writeln('No books available.')
    ).

% List all issued books with user details
list_issued_books :-
    findall((BookName, UserName),
        (book(BookName, BookID, issued),
         issued_to(BookID, UserID),
         user(UserName, UserID)),
         IssuedBooks),
    (   IssuedBooks \= []
    ->  format('Issued Books (Book - User): ~w~n', [IssuedBooks])
    ;   writeln('No books issued.')
    ).