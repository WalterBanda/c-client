import 'package:client/styles/icons/chapchap.dart';
import 'package:client/widgets/screens/auth/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/sandbox.dart';

void main() {
  group('Splash screen tests', () {
    testWidgets(
        'UI tests: Test if splash screen show the respective UI element',
        (tester) async {
      await tester.pumpWidget(const Sandbox(testWidget: Logo()));

      // Checks respective widgets in tree
      expect(find.text('ChapChap'), findsOneWidget);
      expect(find.byIcon(ChapChap.logo), findsOneWidget);
    });
  });

  group("Create Account Shortcut Tests", () {
    testWidgets("UI Tests: Check if the widgets has all children",
        (widgetTester) async {
      await widgetTester
          .pumpWidget(const Sandbox(testWidget: CreateAccountShortcut()));

      // Check for given text components
      expect(find.text("Don’t have an Account ?  "), findsOneWidget);
      expect(find.text("Create Account"), findsOneWidget);
      // Check if the component has all components
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
    });
  });
}
