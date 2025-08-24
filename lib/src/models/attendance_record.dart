class AttendanceRecord {
  final String id;
  final String classId;
  final String studentId;
  final DateTime date;
  final String status; // 'present' | 'absent' | 'late'

  const AttendanceRecord({required this.id, required this.classId, required this.studentId, required this.date, required this.status});

  Map<String, dynamic> toMap() => {
        'classId': classId,
        'studentId': studentId,
        'date': date.toIso8601String(),
        'status': status,
      };

  factory AttendanceRecord.fromMap(String id, Map<String, dynamic> map) => AttendanceRecord(
        id: id,
        classId: (map['classId'] ?? '') as String,
        studentId: (map['studentId'] ?? '') as String,
        date: DateTime.tryParse((map['date'] ?? '') as String) ?? DateTime.now(),
        status: (map['status'] ?? 'present') as String,
      );
}