import 'package:flutter/material.dart';

// 🏘️ Local imports
import '../../router/roles.dart';
import '../../styles/icons/chap_chap_icons.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  static const id = "about";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 27, right: 27),
      maintainBottomViewPadding: false,
      child: ConstrainedBox(
        constraints: pageConstraints,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(ChapChap.logo, size: 100),
              const SizedBox(height: 24),
              Text(
                'Its an opensource application, with a couple of features. I you like its concept you can checkout its github repo and contribute ',
                style: Theme.of(context).textTheme.bodyText2!,
              ),
              const SizedBox(height: 4),
              Text(
                'https://github.com/WalterBanda/chapchap-app',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              TextButton(
                child: Text(
                  'Show Licences',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                onPressed: () => showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(ChapChap.logo, size: 100),
                  applicationName: "ChapChap",
                  applicationLegalese: '\u{a9} 2022 Banda Dev',
                  applicationVersion: '1.0.0',
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      "ChapChap is a proof-of-concept application that was created "
                      'for service providers that deliver mechanical services locally.',
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Its an opensource application, with a couple of features. I you like its concept you can checkout its github repo and contribute ',
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'https://github.com/WalterBanda/chapchap-app',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
