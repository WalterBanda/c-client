import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'route/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      // TODO: Implement Theming 🎨
      darkTheme: ThemeData.light(),
      navigatorKey: GlobalNavigator.router,
      initialRoute: GlobalNavigator.initialRoute(),
      onGenerateRoute: GlobalNavigator.generateRoute,
    );
  }
}
