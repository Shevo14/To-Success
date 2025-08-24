import 'dart:developer' as developer;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static Future<void> initialize() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.onMessage.listen((msg) {
        developer.log('Foreground message: ${msg.messageId}', name: 'NotificationService');
      });
    } catch (e, st) {
      if (kDebugMode) {
        developer.log('Notification init error: $e', name: 'NotificationService', stackTrace: st);
      }
    }
  }
}