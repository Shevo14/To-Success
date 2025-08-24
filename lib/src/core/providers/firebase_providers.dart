import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);
final storageProvider = Provider<FirebaseStorage>((_) => FirebaseStorage.instance);
final messagingProvider = Provider<FirebaseMessaging>((_) => FirebaseMessaging.instance);

final userDocProvider = StreamProvider<DocumentSnapshot<Map<String, dynamic>>?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final db = ref.watch(firestoreProvider);
  final user = auth.currentUser;
  if (user == null) return const Stream.empty();
  return db.collection('users').doc(user.uid).snapshots();
});

final userRoleProvider = Provider<String?>((ref) {
  final docAsync = ref.watch(userDocProvider);
  return docAsync.asData?.value?.data()?['role'] as String?;
});