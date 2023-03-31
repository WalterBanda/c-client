import 'package:flutter/material.dart';

class RouterAnimations {
  static Duration duration = const Duration(milliseconds: 250);

  static RouteTransitionsBuilder fade = (context, animation, _, child) {
    final curveTween = CurveTween(curve: Curves.decelerate);
    Tween opacity = Tween(begin: 1, end: 0);
    return FadeTransition(
      opacity: animation.drive(opacity).drive(curveTween),
      child: child,
    );
  };
}
