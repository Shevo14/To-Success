class Student {
  final String id;
  final String name;
  final String email;

  Student({required this.id, required this.name, required this.email});

  factory Student.fromMap(String id, Map<String, dynamic> data) {
    return Student(
      id: id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
      };
}