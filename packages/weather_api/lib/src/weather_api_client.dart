import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:weather_api/weather_api.dart';

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// Thrown if an `http` request returns a non-200 status code.
class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown when an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

class WeatherApiClient {
  WeatherApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// The host URL used for all API requests.
  @visibleForTesting
  static const authority = 'www.metaweather.com';

  final http.Client _httpClient;

  /// Fetches search results by Name.
  /// REST call: 'GET /api/locationsearch/?query={City Name}
  Future<List<SearchResult>> fetchByCity(String term) async {
    final uri = Uri.https(authority, '/api/location/search/', {'query': term});
    final responseBody = await _get(uri);

    try {
      return responseBody
          .map((dynamic item) =>
              SearchResult.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  /// Fetches search results by Lat Long.
  /// REST call: 'GET /api/locationsearch/?lattlong={Lat,Long}
  Future<List<SearchResult>> fetchByLatLng(String term) async {
    final uri =
        Uri.https(authority, '/api/location/search/', {'lattlong': term});
    final responseBody = await _get(uri);

    try {
      return responseBody
          .map((dynamic item) =>
              SearchResult.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  /// Fetches weather for a specific WoeID.
  /// REST call: 'GET /api/location{woeid}/
  Future<LocationWeather> fetchLocationWeather(int id) async {
    final uri = Uri.https(authority, '/api/location/${id.toString()}');
    final responseBody = await _getLocation(uri);
    try {
      return LocationWeather.fromJson(responseBody);
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<List<dynamic>> _get(Uri uri) async {
    http.Response response;
    try {
      response = await _httpClient.get(uri);
    } catch (_) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      return json.decode(response.body) as List;
    } catch (_) {
      throw JsonDecodeException();
    }
  }

  Future<dynamic> _getLocation(Uri uri) async {
    http.Response response;
    try {
      response = await _httpClient.get(uri);
    } catch (_) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      return json.decode(response.body);
    } catch (_) {
      throw JsonDecodeException();
    }
  }
}
