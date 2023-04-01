import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String platform = kIsWeb ? "Page" : "Screen";
    return Text("$platform not Found");
  }
}
