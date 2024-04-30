import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apikey;

  WeatherService(this.apikey);

  Future<Weather> getWeather(String cityName) async {
    print(cityName);
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    print(response.body);
    if ((response.statusCode == 200)) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );
    print(position.latitude);

    //convert location into a list of place mark objects
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract city name from the first place mark
    String? city = placeMarks[0].locality;
    return city ?? '';
  }
}
