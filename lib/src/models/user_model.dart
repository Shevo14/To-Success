class AppUser {
  final String id;
  final String email;
  final String role; // 'teacher' or 'student'

  const AppUser({required this.id, required this.email, required this.role});

  Map<String, dynamic> toMap() => {
        'email': email,
        'role': role,
      };

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
        id: id,
        email: (map['email'] ?? '') as String,
        role: (map['role'] ?? 'student') as String,
      );
}