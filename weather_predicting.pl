% Knowledge base: Assign confidence scores to conditions
rain_probability(Cloudy, Humidity, Wind, Score) :-
    Cloudy == yes, Humidity == high, Wind \== strong, Score is 90.
rain_probability(Cloudy, Humidity, _, Score) :-
    Cloudy == yes, Humidity == high, Score is 75.
rain_probability(Cloudy, _, _, Score) :-
    Cloudy == yes, Score is 60.
rain_probability(_, Humidity, _, Score) :-
    Humidity == high, Score is 50.
rain_probability(_, _, _, Score) :-
    Score is 10.  % Default low chance if no condition met

% Decision threshold
predict_weather(Cloudy, Humidity, Wind, rain) :-
    rain_probability(Cloudy, Humidity, Wind, Score),
    Score >= 50, !.

predict_weather(_, _, _, no_rain).

% For more detailed prediction with percentage
detailed_weather(Cloudy, Humidity, Wind, Prediction, Score) :-
    rain_probability(Cloudy, Humidity, Wind, Score),
    (Score >= 50 -> Prediction = rain ; Prediction = no_rain).
