import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';

void main() {
  group('Search Result', () {
    test('has concise toString', () {
      expect(
        const SearchResult(
          title: 'Denver',
          woeID: 1234,
        ).toString(),
        equals('Search Result(1234, Denver)'),
      );
    });
  });
}
