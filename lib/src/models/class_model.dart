class ClassModel {
  final String id;
  final String name;
  final String teacherId;
  final List<String> studentIds;

  const ClassModel({required this.id, required this.name, required this.teacherId, required this.studentIds});

  Map<String, dynamic> toMap() => {
        'name': name,
        'teacherId': teacherId,
        'studentIds': studentIds,
      };

  factory ClassModel.fromMap(String id, Map<String, dynamic> map) => ClassModel(
        id: id,
        name: (map['name'] ?? '') as String,
        teacherId: (map['teacherId'] ?? '') as String,
        studentIds: List<String>.from((map['studentIds'] ?? const <String>[]) as List),
      );
}