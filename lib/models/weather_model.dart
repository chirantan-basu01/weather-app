class Weather {
  final String cityName;
  final String temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toString(),
      mainCondition: json['weather'][0]['description'],
    );
  }
}
