// Use Firebase emulators

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

// Use Emulator on Debug build
const bool useEmulator = kDebugMode;
// const bool useEmulator = false;

// Settings for firebase emulator connection
connectToEmulator() async {
  // Provide url to the emulator, localhost might not work on android emulator.
  // final host = Platform.isAndroid ? '10.0.2.2' : 'localhost'; //#1
  const host = 'localhost'; //#1
  // Provide port for all the local emulator prodcuts
  // #2
  const authPort = 9099;
  const firestorePort = 8080;
  // const functionsPort = 5001;
  const storagePort = 9199;

  // Just to make sure we're running locally
  if (kDebugMode) {
    print("I am running on emulator");
  }

  // Instruct all the relevant firebase products to use the firebase emulator
  // # 3
  await FirebaseAuth.instance.useAuthEmulator(host, authPort);
  FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
  // FirebaseFunctions.instance.useFunctionsEmulator(host, functionsPort);
  FirebaseStorage.instance.useStorageEmulator(host, storagePort);
}
