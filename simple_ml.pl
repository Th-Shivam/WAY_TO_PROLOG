% --- Facts: historical data ---
play_tennis(sunny, hot, high, weak, no).
play_tennis(sunny, hot, high, strong, no).
play_tennis(overcast, hot, high, weak, yes).
play_tennis(rain, mild, high, weak, yes).
play_tennis(rain, cool, normal, weak, yes).
play_tennis(rain, cool, normal, strong, no).
play_tennis(overcast, cool, normal, strong, yes).
play_tennis(sunny, mild, high, weak, no).
play_tennis(sunny, cool, normal, weak, yes).
play_tennis(rain, mild, normal, weak, yes).
play_tennis(sunny, mild, normal, strong, yes).
play_tennis(overcast, mild, high, strong, yes).
play_tennis(overcast, hot, normal, weak, yes).
play_tennis(rain, mild, high, strong, no).

% --- Main Rule: exact match prediction ---
predict(Outlook, Temp, Humidity, Wind, Result) :-
    play_tennis(Outlook, Temp, Humidity, Wind, Result),
    format('Exact match found: ~w ~w ~w ~w => ~w~n', [Outlook, Temp, Humidity, Wind, Result]).

% --- Fallback: partial match (ignore Wind) ---
predict(Outlook, Temp, Humidity, _, Result) :-
    play_tennis(Outlook, Temp, Humidity, _, Result),
    format('Partial match (ignoring Wind): ~w ~w ~w => ~w~n', [Outlook, Temp, Humidity, Result]).

% --- Fallback: guess based on Outlook only ---
predict(Outlook, _, _, _, Result) :-
    findall(R, play_tennis(Outlook, _, _, _, R), Results),
    majority_vote(Results, Result),
    format('Guess based on Outlook (~w): ~w~n', [Outlook, Result]).

% --- Utility: find majority vote ---
majority_vote(Results, yes) :-
    include(=(yes), Results, YesList),
    length(YesList, YesCount),
    length(Results, Total),
    YesCount >= Total / 2, !.

majority_vote(_, no).

% --- Sample Queries ---
% ?- predict(rain, mild, high, weak, X).
% ?- predict(sunny, hot, high, weak, X).
% ?- predict(overcast, cool, high, weak, X).
% ?- predict(sunny, _, normal, _, X).