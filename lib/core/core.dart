import 'package:flutter/material.dart';

// 🏘️ Local imports
import '../styles/ui/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChapChap",
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgDark,
        fontFamily: "SF Pro Rounded",
      ),
      // TODO: Implement Theming 🎨
      home: const MyHomePage(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
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
        children: const [
          Text('A random idea:'),
        ],
      ),
    );
  }
}
