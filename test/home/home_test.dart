import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/providers/weather_provider.dart';
import 'package:very_good_weather/widgets/home/home.dart';
import 'package:very_good_weather/widgets/home/show_results.dart';
import 'package:weather_api/weather_api.dart';

import '../helpers/pump_app.dart';

void main() {
  WeatherProvider _weatherProvider;

  setUp(() {
    _weatherProvider = WeatherProvider();
  });

  group('HomePage', () {
    testWidgets(
      'renders Column',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        expect(find.byType(Column), findsOneWidget);
      },
    );

    testWidgets(
      'renders Logo',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        expect(find.byType(SvgPicture), findsOneWidget);
      },
    );

    testWidgets(
      'does not renders ResultsList',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        expect(find.byType(ResultsList), findsNothing);
      },
    );
  });

  group('HomePage with results', () {
    testWidgets(
      'renders Column',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        expect(find.byType(Column), findsOneWidget);
      },
    );

    testWidgets(
      'does not render SVG Logo',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .updateSearchResults(
                [const SearchResult(title: 'Test', woeID: 1234)]);
        await tester.pumpAndSettle();
        expect(find.byType(SvgPicture), findsNothing);
      },
    );

    testWidgets(
      'renders ResultsList',
      (tester) async {
        await tester.pumpApp(const HomeScreen());
        final context = tester.element(find.byType(Column));
        Provider.of<WeatherProvider>(context, listen: false)
            .updateSearchResults(
                [const SearchResult(title: 'Test', woeID: 1234)]);
        await tester.pumpAndSettle();
        expect(find.byType(ResultsList), findsOneWidget);
      },
    );
  });
}
