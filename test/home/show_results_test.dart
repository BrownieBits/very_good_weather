import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/providers/weather_provider.dart';
import 'package:very_good_weather/widgets/home/home.dart';
import 'package:weather_api/weather_api.dart';

import '../helpers/pump_app.dart';

void main() {
  WeatherProvider _weatherProvider;

  setUp(() {
    _weatherProvider = WeatherProvider();
  });

  group('ShowWeather', () {
    testWidgets(
      'renders ListView',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .updateSearchResults(
                [const SearchResult(title: 'Test', woeID: 1234)]);
        await tester.pumpAndSettle();
        expect(find.byType(ListView), findsOneWidget);
      },
    );

    testWidgets(
      'renders Find City Names',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .updateSearchResults([
          const SearchResult(title: 'Test', woeID: 1234),
          const SearchResult(title: 'Denver', woeID: 1234)
        ]);
        await tester.pumpAndSettle();
        expect(find.text('Test'), findsOneWidget);
        expect(find.text('Denver'), findsOneWidget);
      },
    );
  });
}
