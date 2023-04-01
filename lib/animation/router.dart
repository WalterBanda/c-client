import 'package:flutter/material.dart';

class RouterAnimations {
  static Duration duration = const Duration(milliseconds: 250);

  static RouteTransitionsBuilder fade = (context, animation, _, child) {
    final curveTween = CurveTween(curve: Curves.easeInOut);
    return FadeTransition(
      opacity: animation.drive(curveTween),
      child: child,
    );
  };
}
