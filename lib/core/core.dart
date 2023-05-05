import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/theme/manager.dart';
import '../design/theme/theme.dart';

// 🏘️ Local imports

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChapChap",
      themeMode: Provider.of<ThemeManager>(context).mode,
      theme: Theming.light,
      darkTheme: Theming.dark,
      // TODO: Initial Route checking based on the authentication status
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "🤔 Building router config",
                style: Theme.of(context).textTheme.title,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Themed button'))
            ],
          ),
        ),
      ),
    );
  }
}
