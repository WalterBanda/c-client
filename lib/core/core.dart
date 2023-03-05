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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
        ],
      ),
    );
  }
}
