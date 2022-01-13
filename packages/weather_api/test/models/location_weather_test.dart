import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';

void main() {
  group('Location Weather', () {
    test('has concise toString', () {
      expect(
        LocationWeather(
            woeID: 1234,
            title: 'Denver',
            sunRise: DateTime.now(),
            sunSet: DateTime.now().add(const Duration(hours: 12)),
            forecast: []).toString(),
        equals('The WOE ID for Denver is 1234'),
      );
    });
  });

  group('Consolidated Weather', () {
    test('has concise toString', () {
      expect(
        ConsolidatedWeather(
                weatherStateName: 'Showers',
                applicableDate: DateTime.parse('2022-01-09'),
                minTemp: -4.025,
                maxTemp: 4.390000000000001,
                theTemp: 6.725,
                windSpeed: 3.5718365130014047,
                windDirection: 'S',
                airPressure: 1021.0,
                humidity: 62,
                visibility: 15.54794997216257)
            .toString(),
        equals(
            'The temperature on 2022-01-09 00:00:00.000 will be 6.725 Celsius.'),
      );
    });
  });
}
