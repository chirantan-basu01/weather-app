
import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/models/weather_model.dart';

void main() {
  group('Weather', () {
    test('fromJson creates a Weather instance with correct values', () {
      // Arrange
      final json = {
        'name': 'London',
        'main': {'temp': 15.5},
        'weather': [{'main': 'Clouds'}]
      };

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.cityName, 'London');
      expect(weather.temperature, 15.5);
      expect(weather.mainCondition, 'Clouds');
    });

    test('fromJson throws FormatException if json is missing required keys', () {
      // Arrange
      final json = {'name': 'London'};

      // Act & Assert
      expect(() => Weather.fromJson(json), throwsFormatException);
    });

    test('fromJson throws FormatException if temperature is not a double', () {
      // Arrange
      final json = {
        'name': 'London',
        'main': {'temp': '15.5'},
        'weather': [{'main': 'Clouds'}]
      };

      // Act & Assert
      expect(() => Weather.fromJson(json), throwsFormatException);
    });

    test('fromJson throws FormatException if mainCondition is missing', () {
      // Arrange
      final json = {
        'name': 'London',
        'main': {'temp': 15.5},
        'weather': [{}]
      };

      // Act & Assert
      expect(() => Weather.fromJson(json), throwsFormatException);
    });
  });
}
