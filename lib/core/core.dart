import 'package:client/styles/ui/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/location.dart';
import 'routes/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppData()),
      ],
      child: MaterialApp(
        title: "ChapChap",
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.bgDark,
          fontFamily: "SF Pro Rounded",
        ),
        // TODO: Implement Theming 🎨
        darkTheme: ThemeData.light(),
        navigatorKey: GlobalNavigator.router,
        initialRoute: GlobalNavigator.initialRoute(),
        onGenerateRoute: GlobalNavigator.generateRoute,
      ),
    );
  }
}
