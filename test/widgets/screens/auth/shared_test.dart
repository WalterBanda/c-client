import 'package:client/styles/icons/chapchap.dart';
import 'package:client/widgets/screens/auth/shared.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/sandbox.dart';

void main() {
  group('Splash screen tests', () {
    testWidgets('Test if splash screen show the respective UI element',
        (tester) async {
      await tester.pumpWidget(const Sandbox(testWidget: Logo()));

// Checks respective widgets in tree
      expect(find.text('ChapChap'), findsOneWidget);
      expect(find.byIcon(ChapChap.logo), findsOneWidget);
    });
    testWidgets('Test splash screen element dimensions', (tester) async {
      await tester.pumpWidget(const Sandbox(testWidget: Logo()));

// Checks respective widgets in tree
      expect(find.text('ChapChap'), findsOneWidget);
      expect(find.byIcon(ChapChap.logo), findsOneWidget);
    });
  });
}
