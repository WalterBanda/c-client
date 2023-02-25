import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// 🏘️ Local imports
import 'core/core.dart';
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
