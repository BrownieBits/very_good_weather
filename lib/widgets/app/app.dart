import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_weather/providers/weather_provider.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          secondary: Colors.white,
        ),
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        dividerTheme: const DividerThemeData(
          indent: 16,
          space: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
      ),
      home: context.watch<WeatherProvider>().addedCities.isNotEmpty
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.green,
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.red),
    );
  }
}
