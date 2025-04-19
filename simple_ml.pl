% Facts: historical data
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

% Rule: predict based on past knowledge
predict(Outlook, Temp, Humidity, Wind, Result) :-
    play_tennis(Outlook, Temp, Humidity, Wind, Result).

% Sample Query:
% ?- predict(rain, mild, high, weak, X).
% X = yes.

% ?- predict(sunny, hot, high, weak, X).
% X = no.
