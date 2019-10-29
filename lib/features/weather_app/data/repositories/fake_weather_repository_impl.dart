import 'dart:math';
import 'package:weather_app/core/failures.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather.dart';
import 'package:weather_app/features/weather_app/domain/repositories/weather_repository.dart';

class FakeWeatherRepository implements WeatherRepository {
  double cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkError();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned in for the detailed weather
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        // Return "fetched" weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperatureCelcius: cachedTempCelsius,
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          temperatureCelcius: cachedTempCelsius,
          temperatureFarenheit: cachedTempCelsius * 1.8 + 32,
        );
      },
    );
  }
}
