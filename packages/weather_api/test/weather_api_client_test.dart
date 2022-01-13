import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late Uri cityQuery;
  late Uri latLongQuery;
  late Uri locationQuery;

  group('WeatherApiClient', () {
    late http.Client httpClient;
    late WeatherApiClient subject;

    final localWeather = {
      'woeid': 1234,
      'title': 'Denver',
      'sun_rise': DateTime.now().toIso8601String(),
      'sun_set':
          DateTime.now().add(const Duration(hours: 12)).toIso8601String(),
      'consolidated_weather': [],
    };

    final searchResults = List.generate(
      3,
      (i) => {
        'title': 'Denver',
        'woeid': i,
      },
    );

    setUp(() {
      httpClient = MockHttpClient();
      subject = WeatherApiClient(httpClient: httpClient);
      cityQuery = Uri.https(
          WeatherApiClient.authority, '/api/location/search/?query=Denver');
      latLongQuery = Uri.https(WeatherApiClient.authority,
          '/api/location/search/?lattlong=39.740009,-104.992264');
      locationQuery =
          Uri.https(WeatherApiClient.authority, '/api/location/2391279');
    });

    test('constructor returns normally', () {
      expect(
        () => WeatherApiClient(),
        returnsNormally,
      );
    });

    group('.fetchByCity', () {
      setUp(() {
        when(() => httpClient.get(cityQuery)).thenAnswer(
          (_) async => http.Response(json.encode(searchResults), 200),
        );
      });

      test('throws HttpException when http client throws exception', () {
        when(() => httpClient.get(cityQuery)).thenThrow(Exception());

        expect(
          () => subject.fetchByCity('Denver'),
          throwsA(isA<HttpException>()),
        );
      });

      test(
        'throws HttpRequestFailure when response status code is not 200',
        () {
          when(() => httpClient.get(cityQuery)).thenAnswer(
            (_) async => http.Response('', 400),
          );

          expect(
            () => subject.fetchByCity('Denver'),
            throwsA(
              isA<HttpRequestFailure>()
                  .having((error) => error.statusCode, 'statusCode', 400),
            ),
          );
        },
      );

      test(
        'throws JsonDecodeException when decoding response fails',
        () {
          when(() => httpClient.get(cityQuery)).thenAnswer(
            (_) async => http.Response('definitely not json!', 200),
          );

          expect(
            () => subject.fetchByCity('Denver'),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );

      test(
        'throws JsonDeserializationException '
        'when deserializing json body fails',
        () {
          when(() => httpClient.get(cityQuery)).thenAnswer(
            (_) async => http.Response(
              '[{"this_is_not_a_search_result_doc": true}]',
              200,
            ),
          );

          expect(
            () => subject.fetchByCity('Denver'),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('makes correct request', () async {
        await subject.fetchByCity('Denver');

        verify(
          () => httpClient.get(cityQuery),
        ).called(1);
      });
    });

    group('.fetchByLatLong', () {
      setUp(() {
        when(() => httpClient.get(latLongQuery)).thenAnswer(
          (_) async => http.Response(json.encode(searchResults), 200),
        );
      });

      test('throws HttpException when http client throws exception', () {
        when(() => httpClient.get(latLongQuery)).thenThrow(Exception());

        expect(
          () => subject.fetchByLatLng('39.740009,-104.992264'),
          throwsA(isA<HttpException>()),
        );
      });

      test(
        'throws HttpRequestFailure when response status code is not 200',
        () {
          when(() => httpClient.get(latLongQuery)).thenAnswer(
            (_) async => http.Response('', 400),
          );

          expect(
            () => subject.fetchByLatLng('39.740009,-104.992264'),
            throwsA(
              isA<HttpRequestFailure>()
                  .having((error) => error.statusCode, 'statusCode', 400),
            ),
          );
        },
      );

      test(
        'throws JsonDecodeException when decoding response fails',
        () {
          when(() => httpClient.get(latLongQuery)).thenAnswer(
            (_) async => http.Response('definitely not json!', 200),
          );

          expect(
            () => subject.fetchByLatLng('39.740009,-104.992264'),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );

      test(
        'throws JsonDeserializationException '
        'when deserializing json body fails',
        () {
          when(() => httpClient.get(latLongQuery)).thenAnswer(
            (_) async => http.Response(
              '[{"this_is_not_a_search_result_doc": true}]',
              200,
            ),
          );

          expect(
            () => subject.fetchByLatLng('39.740009,-104.992264'),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('makes correct request', () async {
        await subject.fetchByLatLng('39.740009,-104.992264');

        verify(
          () => httpClient.get(latLongQuery),
        ).called(1);
      });
    });

    group('.fetchLocationWeather', () {
      setUp(() {
        when(() => httpClient.get(locationQuery)).thenAnswer(
          (_) async => http.Response(json.encode(localWeather), 200),
        );
      });

      test('throws HttpException when http client throws exception', () {
        when(() => httpClient.get(locationQuery)).thenThrow(Exception());

        expect(
          () => subject.fetchLocationWeather(2391279),
          throwsA(isA<HttpException>()),
        );
      });

      test(
        'throws HttpRequestFailure when response status code is not 200',
        () {
          when(() => httpClient.get(locationQuery)).thenAnswer(
            (_) async => http.Response('', 400),
          );

          expect(
            () => subject.fetchLocationWeather(2391279),
            throwsA(
              isA<HttpRequestFailure>()
                  .having((error) => error.statusCode, 'statusCode', 400),
            ),
          );
        },
      );

      test(
        'throws JsonDecodeException when decoding response fails',
        () {
          when(() => httpClient.get(locationQuery)).thenAnswer(
            (_) async => http.Response('definitely not json!', 200),
          );

          expect(
            () => subject.fetchLocationWeather(2391279),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );

      test(
        'throws JsonDeserializationException '
        'when deserializing json body fails',
        () {
          when(() => httpClient.get(locationQuery)).thenAnswer(
            (_) async => http.Response(
              '[{"this_is_not_a_location_weather_doc": true}]',
              200,
            ),
          );

          expect(
            () => subject.fetchLocationWeather(2391279),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('makes correct request', () async {
        await subject.fetchLocationWeather(2391279);

        verify(
          () => httpClient.get(locationQuery),
        ).called(1);
      });
    });
  });
}
