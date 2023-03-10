import 'package:client/design/theme/manager.dart';
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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "SF Pro Rounded",
      ),
      // TODO: Implement Theming 🎨
      darkTheme: ThemeData.dark(),
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
      body: Column(
        children: [
          Text(
              'A random idea: ${Provider.of<ThemeManager>(context).mode.toString()}'),
          ElevatedButton.icon(
            onPressed: () => Provider.of<ThemeManager>(context, listen: false)
                .changeTheme(ThemeMode.dark),
            icon: const Icon(ChapChap.light),
            label: const Text("Change Theme"),
          ),
        ],
      ),
    );
  }
}
