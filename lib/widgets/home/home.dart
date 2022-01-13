import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<WeatherProvider>().addedCities.isNotEmpty
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green,
          )
        : Container(
            height: double.infinity, width: double.infinity, color: Colors.red);
  }
}
