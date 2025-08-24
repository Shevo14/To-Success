import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform {
    if (kIsWeb) {
      return null; // Web requires explicit options via flutterfire
    }
    // For Android/iOS, native config can be used, so returning null lets initializeApp() fallback.
    return null;
  }
}