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
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Consumer<ThemeManager>(
          builder: (context, manager, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppBar(
                title: const Text('Widget Theming'),
                leading: IconButton(
                  icon: const Icon(ChapChap.menu),
                  tooltip: 'Change theme',
                  onPressed: () {
                    // handle the press
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(ChapChap.light),
                    tooltip: 'Change theme',
                    onPressed: () {
                      // handle the press
                    },
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const CircleAvatar(
                            child: FlutterLogo(),
                          ),
                          const Text(
                            "Username",
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.home),
                            label: const Text("Home"),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.admin),
                            label: const Text("Admin"),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.garage),
                            label: const Text("Garage"),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.settings),
                            label: const Text("Settings"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Logout"),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text("Elevated Button")),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.login),
                            label: const Text("Icon Button Sample, Login"),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("textBtn")),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(ChapChap.login),
                            label: const Text("Icon Button Sample, Login"),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(ChapChap.github)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
