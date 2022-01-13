import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/weather_api.dart';

import '/providers/weather_provider.dart';
import '/widgets/show_weather/button.dart';
import '/widgets/show_weather/forecast_list.dart';

class ShowWeather extends StatefulWidget {
  const ShowWeather({Key? key}) : super(key: key);

  @override
  State<ShowWeather> createState() => _ShowWeatherState();
}

class _ShowWeatherState extends State<ShowWeather> {
  late WeatherProvider weatherProvider;

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();
    double temp = weatherProvider.locationWeather!.forecast[0].theTemp;
    double minTemp = weatherProvider.locationWeather!.forecast[0].minTemp;
    double maxTemp = weatherProvider.locationWeather!.forecast[0].maxTemp;

    if (weatherProvider.currentTempType != 'C') {
      temp = changeToFahrenheit(temp);
      minTemp = changeToFahrenheit(minTemp);
      maxTemp = changeToFahrenheit(maxTemp);
    }
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                weatherProvider.clearLocation();
              },
              child: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onBackground,
                size: 36,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(weatherProvider.locationWeather!.title,
                  style: Theme.of(context).textTheme.headline2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 15),
            MyButton(
              onTap: () {
                weatherProvider.updateTempType();
              },
              child: Text(
                '${weatherProvider.currentTempType}°',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
            ),
            const SizedBox(width: 15),
            MyButton(
                onTap: () {
                  weatherProvider.updateLocationWeather(
                      SearchResult(
                          title: weatherProvider.locationWeather!.title,
                          woeID: weatherProvider.locationWeather!.woeID),
                      weatherProvider.searchTerm);
                },
                child: Icon(Icons.refresh,
                    color: Theme.of(context).colorScheme.surface))
          ],
        ),
        const SizedBox(height: 30),
        Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text('Today',
                          style: Theme.of(context).textTheme.headline3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 15),
                    Text(
                        DateFormat('E MMM, d').format(weatherProvider
                            .locationWeather!.forecast[0].applicableDate),
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('${temp.toStringAsPrecision(2)}°',
                              style: Theme.of(context).textTheme.headline1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 12),
                              Text('${minTemp.toStringAsPrecision(2)}°',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(width: 15),
                              Icon(Icons.arrow_upward,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 12),
                              Text('${maxTemp.toStringAsPrecision(2)}°',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/weather_icons/${weatherProvider.locationWeather!.forecast[0].weatherStateName.toLowerCase().replaceAll(' ', '_')}.svg',
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ForecastList(forecast: weatherProvider.locationWeather!.forecast)
      ],
    );
  }

  double changeToFahrenheit(double value) {
    return (value * (9 / 5)) + 32;
  }
}
