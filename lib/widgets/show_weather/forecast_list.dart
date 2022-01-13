import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/weather_api.dart';

import '/providers/weather_provider.dart';

class ForecastList extends StatelessWidget {
  final List<ConsolidatedWeather> forecast;
  const ForecastList({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: forecast.length,
          itemBuilder: (BuildContext context, int index) {
            if (index != 0) {
              double temp = forecast[index].theTemp;

              if (context.watch<WeatherProvider>().currentTempType != 'C') {
                temp = (temp * (9 / 5)) + 32;
              }
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(5),
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                              DateFormat('E MMM, d')
                                  .format(forecast[index].applicableDate),
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 15),
                        Text('${temp.toStringAsPrecision(2)}°',
                            style: Theme.of(context).textTheme.bodyText2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/images/weather_icons/${forecast[index].weatherStateName.toLowerCase().replaceAll(' ', '_')}.svg',
                          height: 24,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
