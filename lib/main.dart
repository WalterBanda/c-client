import 'package:client/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import 'design/theme/manager.dart';

void main() async {
  //  concrete binding for applications based on the Widgets framework
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(PathUrlStrategy());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeManager(),
        )
      ],
      child: const App(),
    ),
  );
}
