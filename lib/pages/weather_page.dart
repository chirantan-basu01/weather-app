import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('b220e514e41756b7674de07929b9261b');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      if (kDebugMode) {
        print(
            'Weather: ${weather.temperature}---${weather.mainCondition}---${weather.cityName}');
      }
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny_animation.json'; //default to sunny
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy_animation.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy_animation.json';
      case 'thunderstorm':
        return 'assets/thunder_animation.json';
      case 'clear':
        return 'assets/sunny_animation.json';
      default:
        return 'assets/sunny_animation.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[000],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? 'loading city...'),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text(_weather?.temperature ?? ''),

            //weather condition
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
