import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/providers/weather_provider.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    return pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(home: innerChild),
    ));
  }
}
