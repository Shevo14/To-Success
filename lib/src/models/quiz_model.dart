import 'question_model.dart';

class QuizModel {
  final String id;
  final String classId;
  final String title;
  final int durationSeconds;
  final List<Question> questions;
  final DateTime createdAt;

  const QuizModel({
    required this.id,
    required this.classId,
    required this.title,
    required this.durationSeconds,
    required this.questions,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'classId': classId,
        'title': title,
        'durationSeconds': durationSeconds,
        'questions': questions.map((q) => q.toMap()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory QuizModel.fromMap(String id, Map<String, dynamic> map) => QuizModel(
        id: id,
        classId: (map['classId'] ?? '') as String,
        title: (map['title'] ?? '') as String,
        durationSeconds: (map['durationSeconds'] ?? 0) as int,
        questions: ((map['questions'] ?? const <Map<String, dynamic>>[]) as List)
            .map((e) => Question.fromMap('q', Map<String, dynamic>.from(e as Map)))
            .toList(),
        createdAt: DateTime.tryParse((map['createdAt'] ?? '') as String) ?? DateTime.now(),
      );
}