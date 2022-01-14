import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/widgets/app/app.dart';
import 'package:very_good_weather/widgets/home/home.dart';

import '../helpers/pump_app.dart';

void main() {
  group('App', () {
    testWidgets(
      'renders AppView',
      (tester) async {
        await tester.pumpApp(const App());
        expect(find.byType(AppView), findsOneWidget);
      },
    );
  });

  group('App View', () {
    testWidgets(
      'renders HomeScreen',
      (tester) async {
        await tester.pumpApp(const AppView());
        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  });
}
