import 'dart:math';

import 'package:client/design/theme/manager.dart';
import 'package:client/design/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design/icons/chapchap.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello')),
      body: Consumer<ThemeManager>(
        builder: (context, manager, child) => Column(
          children: [
            Row(
              children: [
                Text('Current ThemeMode: ${manager.mode}'),
                ElevatedButton.icon(
                  onPressed: () => manager
                      .changeTheme(ThemeMode.values[Random().nextInt(2)]),
                  icon: Icon(
                    manager.mode == ThemeMode.system
                        ? ChapChap.monitor
                        : manager.mode == ThemeMode.light
                            ? ChapChap.light
                            : ChapChap.dark,
                  ),
                  label: const Text("Change Theme"),
                ),
              ],
            ),
            Row(
              children: [
                Text("Current theme: ${Theme.of(context).brightness}"),
                Icon(
                  Theme.of(context).brightness == Brightness.light
                      ? ChapChap.light
                      : ChapChap.dark,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
