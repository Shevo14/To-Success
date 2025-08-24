class GradeItem {
  final String id;
  final String classId;
  final String studentId;
  final String category; // 'assignment' | 'quiz' | 'lecture'
  final String title;
  final double score;
  final double maxScore;
  final DateTime date;

  const GradeItem({
    required this.id,
    required this.classId,
    required this.studentId,
    required this.category,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'classId': classId,
        'studentId': studentId,
        'category': category,
        'title': title,
        'score': score,
        'maxScore': maxScore,
        'date': date.toIso8601String(),
      };

  factory GradeItem.fromMap(String id, Map<String, dynamic> map) => GradeItem(
        id: id,
        classId: (map['classId'] ?? '') as String,
        studentId: (map['studentId'] ?? '') as String,
        category: (map['category'] ?? 'assignment') as String,
        title: (map['title'] ?? '') as String,
        score: ((map['score'] ?? 0) as num).toDouble(),
        maxScore: ((map['maxScore'] ?? 0) as num).toDouble(),
        date: DateTime.tryParse((map['date'] ?? '') as String) ?? DateTime.now(),
      );
}