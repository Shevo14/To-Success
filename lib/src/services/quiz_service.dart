import 'package:cloud_firestore/cloud_firestore.dart';

class QuizService {
  final FirebaseFirestore db;
  const QuizService(this.db);

  Future<DocumentReference<Map<String, dynamic>>> createQuiz({required String classId, required Map<String, dynamic> quizData}) async {
    return db.collection('classes').doc(classId).collection('quizzes').add(quizData);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchQuizzes(String classId) {
    return db.collection('classes').doc(classId).collection('quizzes').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> submitAnswers({required String classId, required String quizId, required String studentId, required List<int> answers, required int score}) async {
    await db
        .collection('classes')
        .doc(classId)
        .collection('quizzes')
        .doc(quizId)
        .collection('submissions')
        .doc(studentId)
        .set({'answers': answers, 'score': score, 'submittedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }
}