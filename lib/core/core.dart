import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import 'providers/location.dart';
import 'providers/appdata.dart';
import 'providers/user.dart';
import '../styles/ui/colors.dart';
import '../routes/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LocationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AppData()),
      ],
      child: MaterialApp(
        title: "ChapChap",
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
