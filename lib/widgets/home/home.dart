import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/providers/weather_provider.dart';
import '/widgets/home/show_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchField = TextEditingController();
  late FocusNode _searchFocus;
  late WeatherProvider weatherProvider;

  @override
  void initState() {
    _searchFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    weatherProvider = context.watch<WeatherProvider>();
    return Column(
      mainAxisAlignment: weatherProvider.searchResults.isEmpty
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        if (weatherProvider.searchResults.isEmpty) ...[
          SizedBox(
              height: 128,
              child: SvgPicture.asset('assets/images/VGWVertical.svg')),
          const SizedBox(
            height: 60,
          ),
        ],
        Text(
          'Search for a city by name to find it\'s current weather and forecast',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            focusNode: _searchFocus,
            controller: _searchField,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintStyle: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                  color: const Color(0xff333333).withOpacity(.5)),
              labelStyle: const TextStyle(
                  fontSize: 18.0, letterSpacing: 1.5, color: Color(0xff333333)),
              errorStyle: const TextStyle(
                  fontSize: 13.0, letterSpacing: 1.5, color: Colors.red),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'City Name',
            ),
            onChanged: (value) {
              context.read<WeatherProvider>().searchCities(value);
              setState(() {});
            },
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: const Color(0xff333333)),
          ),
        ),
        if (weatherProvider.searchResults.isNotEmpty)
          ResultsList(
            results: weatherProvider.searchResults,
            searchTerm: _searchField.text,
          ),
      ],
    );
  }
}
