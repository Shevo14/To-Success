import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentService {
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  const ContentService({required this.db, required this.storage});

  Future<String> uploadFile({required String classId, required File file, required String mimeType}) async {
    final ref = storage.ref().child('classes').child(classId).child('content').child('${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}');
    final task = await ref.putFile(file, SettableMetadata(contentType: mimeType));
    final path = task.ref.fullPath;
    await db.collection('classes').doc(classId).collection('content').add({
      'title': file.uri.pathSegments.last,
      'description': '',
      'storagePath': path,
      'mimeType': mimeType,
      'sizeBytes': await file.length(),
      'uploadedAt': FieldValue.serverTimestamp(),
    });
    return path;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchContent(String classId) {
    return db.collection('classes').doc(classId).collection('content').orderBy('uploadedAt', descending: true).snapshots();
  }
}