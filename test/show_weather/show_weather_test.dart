import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/providers/weather_provider.dart';
import 'package:very_good_weather/widgets/app/app.dart';
import 'package:very_good_weather/widgets/show_weather/button.dart';
import 'package:very_good_weather/widgets/show_weather/show_weather.dart';
import 'package:weather_api/weather_api.dart';

import '../helpers/pump_app.dart';

void main() {
  WeatherProvider _weatherProvider;

  setUp(() {
    _weatherProvider = WeatherProvider();
  });

  LocationWeather _locationWeather = LocationWeather(
      woeID: 1234,
      title: 'Denver',
      sunRise: DateTime.now(),
      sunSet: DateTime.now().add(const Duration(hours: 12)),
      forecast: [
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now(),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 5.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now(),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 4.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now().add(const Duration(days: 1)),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 3.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now().add(const Duration(days: 2)),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 7.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now().add(const Duration(days: 3)),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 9.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
        ConsolidatedWeather(
            weatherStateName: 'Clear',
            applicableDate: DateTime.now().add(const Duration(days: 4)),
            minTemp: 3.0,
            maxTemp: 10.0,
            theTemp: 3.0,
            windSpeed: 15,
            windDirection: 'SW',
            airPressure: 150,
            humidity: 150,
            visibility: 150),
      ]);

  group('ShowWeather', () {
    testWidgets(
      'renders Column',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.byType(ShowWeather), findsWidgets);
      },
    );

    testWidgets(
      'renders Column',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.byType(Column), findsWidgets);
      },
    );

    testWidgets(
      'renders Row',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.byType(Row), findsWidgets);
      },
    );

    testWidgets(
      'renders Back Button',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      },
    );

    testWidgets(
      'renders City Title',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.text('Denver'), findsOneWidget);
      },
    );

    testWidgets(
      'renders MyButtons',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.byType(MyButton), findsWidgets);
      },
    );

    testWidgets(
      'renders Today',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.text('Today'), findsOneWidget);
      },
    );

    testWidgets(
      'renders Today\'s Date',
      (tester) async {
        DateTime time = DateTime.now();
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.text(DateFormat('E MMM, d').format(time)), findsWidgets);
      },
    );

    testWidgets(
      'Render Celsius Temp',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        expect(find.text('5.0°'), findsWidgets);
      },
    );

    testWidgets(
      'Render Celsius Temp',
      (tester) async {
        await tester.pumpApp(const AppView());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .setLocationWeather(_locationWeather);
        await tester.pumpAndSettle();
        await tester.tap(find.text('C°'));
        await tester.pumpAndSettle();
        expect(find.text('41°'), findsWidgets);
      },
    );
  });
}
