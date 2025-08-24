import 'package:cloud_firestore/cloud_firestore.dart';

class GradesService {
  final FirebaseFirestore db;
  const GradesService(this.db);

  Future<void> setGrade({required String classId, required String studentId, required Map<String, dynamic> grade}) async {
    await db.collection('classes').doc(classId).collection('grades').add({
      ...grade,
      'studentId': studentId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchGradesForStudent(String classId, String studentId) {
    return db
        .collection('classes')
        .doc(classId)
        .collection('grades')
        .where('studentId', isEqualTo: studentId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}