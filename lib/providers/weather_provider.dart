import 'package:flutter/material.dart';
import 'package:weather_api/weather_api.dart';

class WeatherProvider extends ChangeNotifier {
  List<SearchResult> _addedCities = [];

  List<SearchResult> get addedCities => _addedCities;

  void addCity(SearchResult newCity) {
    _addedCities.add(newCity);
    notifyListeners();
  }

  void setCities(List<SearchResult> newCities) {
    _addedCities = newCities;
    notifyListeners();
  }
}
