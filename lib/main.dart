import 'package:client/core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/config/firebase_options.dart';

void main() async {
  //  concrete binding for applications based on the Widgets framework
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const App(), // Wrap your app
  );
}
