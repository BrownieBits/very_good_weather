import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/providers/weather_provider.dart';
import 'package:very_good_weather/widgets/show_weather/button.dart';

import '../helpers/pump_app.dart';

void main() {
  WeatherProvider _weatherProvider;

  setUp(() {
    _weatherProvider = WeatherProvider();
  });

  group('MyButton', () {
    testWidgets(
      'renders GestureDetector',
      (tester) async {
        await tester.pumpApp(MyButton(onTap: () {}, child: Container()));
        expect(find.byType(GestureDetector), findsOneWidget);
      },
    );

    testWidgets(
      'render child of MyButton',
      (tester) async {
        await tester.pumpApp(MyButton(onTap: () {}, child: Container()));
        expect(find.byType(Container), findsOneWidget);
      },
    );
  });
}
