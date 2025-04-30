% Facts: player(Name, Team, Role).
player(virat, india, batsman).
player(rohit, india, batsman).
player(bumrah, india, bowler).
player(dhoni, india, wicketkeeper).

player(warner, australia, batsman).
player(starc, australia, bowler).
player(smith, australia, batsman).
player(carey, australia, wicketkeeper).

% Rule: is_batsman(Name)
is_batsman(Player) :- player(Player, _, batsman).

% Rule: is_bowler(Name)
is_bowler(Player) :- player(Player, _, bowler).

% Rule: same_team(Player1, Player2)
same_team(P1, P2) :- player(P1, Team, _), player(P2, Team, _), P1 \= P2.

% Rule: team_members(Team, Player)
team_members(Team, Player) :- player(Player, Team, _).
