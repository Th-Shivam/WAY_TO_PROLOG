% Facts: team_score(TeamName, Score).
team_score(india, 280).
team_score(australia, 250).
team_score(england, 300).

% Rule: winner(Team)
winner(Team) :-
    team_score(Team, Score),
    \+ (team_score(_, OtherScore), OtherScore > Score).

% Rule: match_result
match_result :-
    winner(Team),
    format('The winner is ~w~n', [Team]).
