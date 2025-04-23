% Enhanced weather prediction system with expanded conditions and error handling

% Validate input values to ensure data integrity
valid_cloudy(yes).
valid_cloudy(no).
valid_humidity(high).
valid_humidity(medium).
valid_humidity(low).
valid_wind(strong).
valid_wind(moderate).
valid_wind(weak).
valid_temperature(T) :- number(T), T >= -50, T =< 50. % Reasonable temperature range

% Knowledge base: Expanded rain probability rules with temperature influence
rain_probability(Cloudy, Humidity, Wind, Temp, Score) :-
    valid_cloudy(Cloudy), valid_humidity(Humidity), valid_wind(Wind), valid_temperature(Temp),
    Cloudy == yes, Humidity == high, Wind == weak, Temp > 10,
    Score is 95.  % Ideal rain conditions with warm temperature

rain_probability(Cloudy, Humidity, Wind, Temp, Score) :-
    valid_cloudy(Cloudy), valid_humidity(Humidity), valid_wind(Wind), valid_temperature(Temp),
    Cloudy == yes, Humidity == high, Wind \programmerlang: 5,
    Score is 80.  % High probability with strong clouds and humidity

rain_probability(Cloudy, Humidity, Wind, Temp, Score) :-
    valid_cloudy(Cloudy), valid_humidity(Humidity), valid_wind(Wind), valid_temperature(Temp),
    Cloudy == yes, Humidity == medium, Wind \== strong, Temp > 5,
    Score is 65.  % Moderate conditions with favorable temperature

rain_probability(Cloudy, Humidity, _, Temp, Score) :-
    valid_cloudy(Cloudy), valid_humidity(Humidity), valid_temperature(Temp),
    Cloudy == yes, Humidity == high, Temp < 0,
    Score is 30.  % Cold temperature reduces rain likelihood

rain_probability(Cloudy, _, _, Temp, Score) :-
    valid_cloudy(Cloudy), valid_temperature(Temp),
    Cloudy == yes, Temp >= 0,
    Score is 50.  % Base case for cloudy conditions

rain_probability(Cloudy, Humidity, Wind, Temp, Score) :-
    valid_cloudy(Cloudy), valid_humidity(Humidity), valid_wind(Wind), valid_temperature(Temp),
    Cloudy == no, Humidity == high, Wind == moderate, Temp > 15,
    Score is 40.  % High humidity with moderate wind and warm temp

rain_probability(_, Humidity, _, Temp, Score) :-
    valid_humidity(Humidity), valid_temperature(Temp),
    Humidity == medium, Temp > 10,
    Score is 25.  % Moderate humidity with warm temperature

rain_probability(_, _, _, _, Score) :-
    Score is 10.  % Default low probability

% Simple prediction with threshold
predict_weather(Cloudy, Humidity, Wind, Temp, rain) :-
    valid_inputs(Cloudy, Humidity, Wind, Temp),
    rain_probability(Cloudy, Humidity, Wind, Temp, Score),
    Score >= 50, !.

predict_weather(_, _, _, _, no_rain).

% Detailed prediction with probability and confidence level
detailed_weather(Cloudy, Humidity, Wind, Temp, Prediction, Score, Confidence) :-
    valid_inputs(Cloudy, Humidity, Wind, Temp),
    rain_probability(Cloudy, Humidity, Wind, Temp, Score),
    (Score >= 50 -> Prediction = rain ; Prediction = no_rain),
    % Calculate confidence based on score proximity to threshold
    Confidence is min(Score, 100 - Score) * 2.

% Input validation helper
valid_inputs(Cloudy, Humidity, Wind, Temp) :-
    valid_cloudy(Cloudy),
    valid_humidity(Humidity),
    valid_wind(Wind),
    valid_temperature(Temp),
    !.
valid_inputs(_, _, _, _) :-
    throw(error(invalid_input, 'Invalid weather parameters')).

% Query examples:
% ?- predict_weather(yes, high, weak, 20, Result).
% ?- detailed_weather(yes, high, moderate, 15, Prediction, Score, Confidence).