import 'package:client/core/core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const App(), // Wrap your app
      ),
    );
