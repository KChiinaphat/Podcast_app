import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAlmEfCpfWHQsed3C49fbYWOiUb2JzrZCY",
    authDomain: "chinnaphat-e2243.firebaseapp.com",
    projectId: "chinnaphat-e2243",
    storageBucket: "chinnaphat-e2243.firebasestorage.app",
    messagingSenderId: "158441232193",
    appId: "1:158441232193:web:3b5b0ef6283389e5eaf3c0",
  );
}