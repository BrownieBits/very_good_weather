import 'package:flutter/material.dart';
import 'package:weather_api/weather_api.dart';
import 'package:provider/provider.dart';

import '/providers/weather_provider.dart';

class ResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final String searchTerm;
  const ResultsList({Key? key, required this.results, required this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                context.read<WeatherProvider>().updateLocationWeather(results[index], searchTerm);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      width: 1.0, color: Theme.of(context).colorScheme.primary),
                )),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        results[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: Theme.of(context).colorScheme.onSurface)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
