import 'package:client/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/theme/manager.dart';
import '../design/theme/theme.dart';

// 🏘️ Local imports

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "ChapChap",
      themeMode: Provider.of<ThemeManager>(context).mode,
      theme: Theming.light,
      darkTheme: Theming.dark,
      // TODO: Initial Route checking based on the authentication status
      routerConfig: AppRouter.config,
    );
  }
}
