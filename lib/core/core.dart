import 'package:client/styles/theme/manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import '../styles/ui/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => ThemeManager(),
        )
      ],
      child: MaterialApp(
        title: "ChapChap",
        themeMode: Provider.of<ThemeManager>(context).mode,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.bgDark,
          fontFamily: "SF Pro Rounded",
        ),
        // TODO: Implement Theming 🎨
        darkTheme: ThemeData.dark(),
        home: const MyHomePage(),
      ),
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
