import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  final FirebaseMessaging messaging;
  final FirebaseFirestore db;
  const NotificationsService({required this.messaging, required this.db});

  Future<void> refreshAndSaveToken(String userId) async {
    final token = await messaging.getToken();
    if (token == null) return;
    await db.collection('users').doc(userId).set({'fcmToken': token}, SetOptions(merge: true));
  }

  Future<void> subscribeToClassTopic(String classId) => messaging.subscribeToTopic('class_$classId');
  Future<void> unsubscribeFromClassTopic(String classId) => messaging.unsubscribeFromTopic('class_$classId');
}