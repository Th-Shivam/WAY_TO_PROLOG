% Rule-based predictions
will_rain(Cloudy, Humidity, Wind) :-
    Cloudy == yes,
    Humidity == high,
    Wind \== strong.

will_rain(Cloudy, Humidity, Wind) :-
    Cloudy == yes,
    Humidity == high.

will_rain(Cloudy, _, _) :-
    Cloudy == yes.

will_rain(_, Humidity, _) :-
    Humidity == high.

% Query handler
predict_weather(Cloudy, Humidity, Wind, rain) :-
    will_rain(Cloudy, Humidity, Wind), !.

predict_weather(_, _, _, no_rain).

