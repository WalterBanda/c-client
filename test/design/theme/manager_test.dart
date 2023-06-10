import 'package:client/design/theme/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../mocks/sandbox.dart';

void main() {
  group('Theme manager tests', () {
    testWidgets('Check if default Theme mode is system', (widgetTester) async {
      await widgetTester.pumpWidget(ProviderSandbox(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeManager())
        ],
        testWidget: const Text('Hello'),
      ));

      final BuildContext context = widgetTester.element(find.byType(Text));

      expect(Provider.of<ThemeManager>(context, listen: false).mode,
          ThemeMode.system);
    });
    testWidgets('Test Theme Switching in Using Provider method',
        (widgetTester) async {
      final childKey = GlobalKey();

      await widgetTester.pumpWidget(ProviderSandbox(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeManager())
        ],
        testWidget: Consumer<ThemeManager>(
          builder: (ctx, manager, child) =>
              Text(key: childKey, 'Theme: ${manager.mode.toString()}'),
        ),
      ));

      // Check for context attachment.
      expect(widgetTester.element(find.byType(Text)),
          equals(childKey.currentContext));

      /// Check is provider is initialized with [ThemeMode.system]
      expect(
          Provider.of<ThemeManager>(childKey.currentContext!, listen: false)
              .mode,
          ThemeMode.system);

      // Check if the text is initialized with [ThemeMode.system]
      expect(
        find.text('Theme: ThemeMode.system'),
        findsOneWidget,
      );

      // Trigger Theme change
      Provider.of<ThemeManager>(childKey.currentContext!, listen: false)
          .changeTheme(ThemeMode.dark);

      // Delay the pump...
      await Future.microtask(widgetTester.pump);

      // Check the value in the provider if its [ThemeMode.dark]
      expect(
        Provider.of<ThemeManager>(childKey.currentContext!, listen: false)
            .mode,
        ThemeMode.dark,
      );

      // Check is widget is updated.
      expect(
        find.text('Theme: ThemeMode.dark'),
        findsOneWidget,
      );
    });
  });
}
