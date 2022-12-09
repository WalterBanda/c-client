import 'package:client/core/core.dart';

// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/config/firebase.dart';
import 'core/config/firebase_options.dart';

void main() async {
  //  concrete binding for applications based on the Widgets framework
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set app to run on firebase emulator
  if (useEmulator) {
    await connectToEmulator();
  }

  runApp(
    App(), // Wrap your app
  );
}
