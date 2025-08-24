import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore db;
  const AttendanceService(this.db);

  Future<void> markAttendance({required String classId, required DateTime date, required Map<String, String> studentIdToStatus}) async {
    final dateId = DateTime(date.year, date.month, date.day).toIso8601String();
    final batch = db.batch();
    final root = db.collection('classes').doc(classId).collection('attendance').doc(dateId);
    batch.set(root, {'date': date.toIso8601String()}, SetOptions(merge: true));
    for (final entry in studentIdToStatus.entries) {
      final doc = root.collection('students').doc(entry.key);
      batch.set(doc, {'status': entry.value});
    }
    await batch.commit();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchAttendanceDates(String classId) {
    return db.collection('classes').doc(classId).collection('attendance').orderBy('date', descending: true).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchAttendanceForDate(String classId, DateTime date) {
    final dateId = DateTime(date.year, date.month, date.day).toIso8601String();
    return db
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .doc(dateId)
        .collection('students')
        .snapshots();
  }
}