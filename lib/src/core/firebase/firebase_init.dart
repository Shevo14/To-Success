import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../firebase_options.dart';

final firebaseInitProvider = FutureProvider<void>((ref) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Request FCM permissions on iOS / Web
  final messaging = FirebaseMessaging.instance;
  if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
    await messaging.requestPermission();
  }
  await messaging.setAutoInitEnabled(true);
});