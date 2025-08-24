class Question {
  final String id;
  final String text;
  final List<String> options; // for MCQ; for T/F, use ['True', 'False']
  final int correctIndex;
  final int points;

  const Question({required this.id, required this.text, required this.options, required this.correctIndex, required this.points});

  Map<String, dynamic> toMap() => {
        'text': text,
        'options': options,
        'correctIndex': correctIndex,
        'points': points,
      };

  factory Question.fromMap(String id, Map<String, dynamic> map) => Question(
        id: id,
        text: (map['text'] ?? '') as String,
        options: List<String>.from((map['options'] ?? const <String>[]) as List),
        correctIndex: (map['correctIndex'] ?? 0) as int,
        points: (map['points'] ?? 1) as int,
      );
}