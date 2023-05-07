import 'package:client/sandbox/nested_routing.dart';
import 'package:client/sandbox/routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import 'core/core.dart';
import 'core/config/firebase_options.dart';
import 'design/theme/manager.dart';

void main() async {
  //  concrete binding for applications based on the Widgets framework
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUrlStrategy(PathUrlStrategy());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeManager(),
        )
      ],
      // child: const App(),
      // child: const NestedRouterDemo(),
      child: const BooksApp(),
    ),
  );
}
