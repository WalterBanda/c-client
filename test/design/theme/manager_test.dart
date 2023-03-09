import 'package:client/design/theme/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../mocks/sandbox.dart';

void main() {
  group("Theme manager tests", () {
    testWidgets("Check if default Theme mode is system", (widgetTester) async {
      await widgetTester.pumpWidget(ProviderSandbox(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeManager())
        ],
        testWidget: const Text("Hello"),
      ));

      final BuildContext context = widgetTester.element(find.byType(Text));

      expect(Provider.of<ThemeManager>(context, listen: false).mode,
          ThemeMode.system);
    });
  });
}
