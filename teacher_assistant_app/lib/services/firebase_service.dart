import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';

class FirebaseService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    try {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (options != null) {
        await Firebase.initializeApp(options: options);
      } else {
        await Firebase.initializeApp();
      }
      _initialized = true;
      developer.log('Firebase initialized', name: 'FirebaseService');
    } catch (e, st) {
      if (kDebugMode) {
        developer.log('Firebase init error: $e', name: 'FirebaseService', stackTrace: st);
      }
      // Allow app to continue; features that need Firebase should handle absence.
    }
  }
}