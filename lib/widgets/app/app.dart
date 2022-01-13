import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/theme.dart';
import '/providers/weather_provider.dart';
import '/widgets/home/home.dart';
import '/widgets/show_weather/show_weather.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: vgwTheme,
        home: Scaffold(
          body: SafeArea(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment
                      .bottomCenter, // 10% of the width, so there are ten blinds.
                  colors: [Color(0xff1903A6), Color(0xff0C0058)],
                )),
                child: context.watch<WeatherProvider>().locationWeather == null
                    ? const HomeScreen()
                    : const ShowWeather()),
          ),
        ));
  }
}
