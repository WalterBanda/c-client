import 'package:flutter/material.dart';

/// This is the color scheme blueprint that would be used to generate the colors for the different themes
/// `🤔` Its similar to [ColorScheme] material class but is suited for this app with custom
/// color aligned into chapchap branding.
///
/// `💡` Has two factory methods [ThemedColors.light] and [ThemedColors.dark] that generate dark and light scheme colors for this app.
class ThemedColors {
  /// Constructor for [ColorScheme], you can customize app colors by specifying the colors inside.
  ThemedColors({
    required this.primary,
    required this.bg,
    required this.input,
    required this.text,
    required this.placeholder,
    required this.translucent,
    required this.gain,
    required this.loss,
    required this.gainGradient,
    required this.lossGradient,
    required this.emphasis,
    required this.error,
    required this.success,
  });

  /// Primary color in the app, applies to [Button] and others background color etc
  Color primary;

  /// Background color of [Scaffold] and other widgets
  Color bg;

  /// Background color of input Elements
  Color input;

  /// This applies a translucent effect on UI elements
  Color translucent;

  /// Primary text color of app
  Color text;

  /// Color of input placeholders
  Color placeholder;

  /// Color that creates an emphasis on a element
  Color emphasis;

  /// Color for all success prompts
  Color success;

  /// Branded color used in errors
  Color error;

  /// This color is used to show gains in graphs
  Color gain;

  /// This color shows losses in graphs
  Color loss;

  /// This gradient color applies to gains, can be used instead of [gain]
  LinearGradient gainGradient;

  /// Gradient that applies to losses, can be used instead of [loss]
  LinearGradient lossGradient;

  /// [ThemedColors] to be applied to [ThemeMode.light]
  static ThemedColors light = ThemedColors(
    primary: const Color.fromRGBO(0, 0, 0, 1),
    bg: const Color.fromRGBO(255, 255, 255, 1),
    input: const Color.fromRGBO(241, 243, 244, 1),
    text: const Color.fromRGBO(0, 0, 0, 1),
    placeholder: const Color.fromRGBO(106, 106, 106, 1),
    translucent: const Color.fromRGBO(0, 0, 0, 0.26),
    gain: const Color.fromRGBO(80, 227, 194, 1),
    loss: const Color.fromRGBO(227, 80, 122, 1),
    gainGradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(48, 154, 255, 1),
        Color.fromRGBO(48, 154, 255, 1),
        Color.fromRGBO(83, 100, 174, 1),
        Color.fromRGBO(112, 54, 107, 0)
      ],
    ),
    lossGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(162, 48, 255, 0),
        Color.fromRGBO(188, 61, 203, 1),
        Color.fromRGBO(227, 80, 122, 1),
      ],
    ),
    emphasis: const Color.fromRGBO(250, 74, 12, 1),
    error: const Color.fromRGBO(255, 26, 26, 1),
    success: const Color.fromRGBO(66, 133, 244, 1),
  );

  /// [ThemedColors] to be applied to [ThemeMode.dark]
  static ThemedColors dark = ThemedColors(
    primary: const Color.fromRGBO(255, 255, 255, 1),
    bg: const Color.fromRGBO(53, 54, 58, 1),
    input: const Color.fromRGBO(32, 33, 36, 1),
    text: const Color.fromRGBO(234, 234, 234, 1),
    placeholder: const Color.fromRGBO(234, 234, 234, 1),
    translucent: const Color.fromRGBO(0, 0, 0, 0.26),
    gain: const Color.fromRGBO(80, 227, 194, 1),
    loss: const Color.fromRGBO(227, 80, 122, 1),
    gainGradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(48, 154, 255, 1),
        Color.fromRGBO(48, 154, 255, 1),
        Color.fromRGBO(83, 100, 174, 1),
        Color.fromRGBO(112, 54, 107, 0)
      ],
    ),
    lossGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(162, 48, 255, 0),
        Color.fromRGBO(188, 61, 203, 1),
        Color.fromRGBO(227, 80, 122, 1),
      ],
    ),
    emphasis: const Color.fromRGBO(250, 74, 12, 1),
    error: const Color.fromRGBO(255, 26, 26, 1),
    success: const Color.fromRGBO(66, 133, 244, 1),
  );

  /// This method facilitates auto switching of color scheme based on the brightness value in [Theme] context. This enables the widget attached to it to autoswitch when the theme is changed thus automatic theming for widgets not covered by the material theming system.
  static ThemedColors adaptive(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return dark;
    }
    return light;
  }
}
