import 'package:flutter/material.dart';
import 'package:weather_api/weather_api.dart';

class WeatherProvider extends ChangeNotifier {
  String _searchTerm = '';
  List<SearchResult> _searchResults = [];
  final WeatherApiClient _weatherApiClient = WeatherApiClient();
  LocationWeather? _locationWeather;
  String _currentTempType = 'C';

  String get searchTerm => _searchTerm;
  List<SearchResult> get searchResults => _searchResults;
  LocationWeather? get locationWeather => _locationWeather;
  String get currentTempType => _currentTempType;

  void searchCities(String term) async {
    if (term == '') {
      _searchResults = [];
    } else {
      _searchResults = await _weatherApiClient.fetchByCity(term);
    }
    notifyListeners();
  }

  void updateLocationWeather(SearchResult newCity, String term) async {
    _searchTerm = term;
    _locationWeather =
        await _weatherApiClient.fetchLocationWeather(newCity.woeID);
    notifyListeners();
  }

  void clearLocation() {
    _locationWeather = null;
    notifyListeners();
  }

  void updateTempType() {
    if (_currentTempType == 'C') {
      _currentTempType = 'F';
    } else {
      _currentTempType = 'C';
    }
    notifyListeners();
  }

  void updateSearchResults(List<SearchResult> newResults) {
    _searchResults = newResults;
    notifyListeners();
  }

  void setLocationWeather(LocationWeather newLocation) {
    _locationWeather = newLocation;
    notifyListeners();
  }
}
