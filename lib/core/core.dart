import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/icons/chapchap.dart';
import '../design/styles/colors.dart';
import '../design/styles/text_styles.dart';
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
      home: const TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

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
                title: const Text('Testing Page'),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: const Icon(ChapChap.menu),
                  tooltip: 'Menu',
                  onPressed: () {
                    // handle the press
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(ChapChap.light),
                    tooltip: 'Change theme',
                    onPressed: () {
                      manager.changeTheme(
                        Theme.of(context).brightness == Brightness.dark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
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
                          CircleAvatar(
                            minRadius: 30,
                            maxRadius: 60,
                            backgroundColor: ThemedColors.adaptive(context)
                                .input
                                .withOpacity(0.7),
                            child: const FlutterLogo(size: 60),
                          ),
                          Text(
                            "Username",
                            style: Theme.of(context).textTheme.headingBold,
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
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SingleChildScrollView(
                              child: Flex(
                                direction: Axis.vertical,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Display',
                                    style: Theme.of(context).textTheme.display,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Title',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Heading',
                                    style: Theme.of(context).textTheme.heading,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Heading/Bold',
                                    style:
                                        Theme.of(context).textTheme.headingBold,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Label',
                                    style: Theme.of(context).textTheme.label,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Label/Bold',
                                    style:
                                        Theme.of(context).textTheme.labelBold,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Headline',
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Headline/Bold',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineBold,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Body',
                                    style: Theme.of(context).textTheme.body,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Body/Semibold',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySemibold,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Body/Bold',
                                    style: Theme.of(context).textTheme.bodyBold,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Caption',
                                    style: TextStyles.caption,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    'Caption/Bold',
                                    style:
                                        Theme.of(context).textTheme.captionBold,
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Elevated Button")),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(ChapChap.login),
                                  label:
                                      const Text("Icon Button Sample, Login"),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("textBtn")),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(ChapChap.login),
                                  label:
                                      const Text("Icon Button Sample, Login"),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(ChapChap.github)),
                              ],
                            ),
                          ],
                        ),
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
