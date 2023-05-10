import 'package:client/design/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();
  static final config = GoRouter(
      initialLocation: 'auth', navigatorKey: router, routes: AppRoutes.routes);
}

class AppRoutes {
  static const String auth = '/auth';
  static const String app = '/';

  static final List<GoRoute> routes = [
    GoRoute(
      path: auth,
      name: 'auth',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Placeholder(
          name: auth,
          next: app,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      name: 'app',
      path: app,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Placeholder(
          name: app,
          next: auth,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          // return FadeTransition(
          // opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
  ];
}

class Placeholder extends StatelessWidget {
  final String name;
  final String next;
  const Placeholder({required this.name, required this.next, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🧪 Testing route $name',
              style: Theme.of(context).textTheme.heading,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => context.go(next),
                child: Text('Navigate to $next'))
          ],
        ),
      ),
    );
  }
}
