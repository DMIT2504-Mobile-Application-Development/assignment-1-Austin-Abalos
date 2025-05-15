import 'dart:core';

class CurrentWeather {
  //region Members
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;
  //endregion

  //region Generative Constructor
  CurrentWeather({
    required String city,
    required String description,
    required double currentTemp,
    required DateTime currentTime,
    required DateTime sunrise,
    required DateTime sunset,
  }) {
    _city = city;
    _description = description;
    _currentTemp = currentTemp;
    _currentTime = currentTime;
    _sunrise = sunrise;
    _sunset = sunset;
  }
  //endregion

  //region Getters
  String get city {
    return _city;
  }

  String get description {
    return _description;
  }

  double get currentTemp {
    return _currentTemp;
  }

  DateTime get currentTime {
    return _currentTime;
  }

  DateTime get sunrise {
    return _sunrise;
  }

  DateTime get sunset {
    return _sunset;
  }
  //endregion

  // region Setters
  set city(String value) {
    if (value.isEmpty) {
      throw Exception('City cannot be empty.');
    }
    _city = value;
  }

  set description(String value) {
    if (value.isEmpty) {
      throw Exception('Description cannot be empty.');
    }
    _description = value;
  }

  set currentTemp(double value) {
    if (value < -100 || value > 100){
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  set sunrise(DateTime value) {
    if (value.year != _currentTime.year ||
        value.month != _currentTime.month ||
        value.day != _currentTime.day) {
      throw Exception('Sunrise must be on the same day as current time');
    }
    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }
    _sunrise = value;
  }

  set sunset(DateTime value) {
    if (value.year != _currentTime.year ||
        value.month != _currentTime.month ||
        value.day != _currentTime.day) {
      throw Exception('Sunset must be on the same day as current time');
    }
    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }
    _sunset = value;
  }
  //endregion

  //region Factory Constructor
  factory CurrentWeather.fromOpenWeatherData(Map<String, dynamic> json) {
    return CurrentWeather(
      city: json['name'],
      description: json['weather'][0]['description'],
      currentTemp: (json['main']['temp'] as num).toDouble(),
      currentTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] * 1000).toInt()),
      sunrise: DateTime.fromMillisecondsSinceEpoch((json['sys']['sunrise'] * 1000).toInt()),
      sunset: DateTime.fromMillisecondsSinceEpoch((json['sys']['sunset'] * 1000).toInt()),
    );
  }
  //endregion

  //region toString method
  @override toString(){
    return 'City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset';
  }
  //endregion

  CurrentWeather.toString();
}



