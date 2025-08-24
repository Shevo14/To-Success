enum UserRole { teacher, student }

extension UserRoleX on UserRole {
  String get asString => this == UserRole.teacher ? 'teacher' : 'student';
  static UserRole fromString(String s) => s == 'teacher' ? UserRole.teacher : UserRole.student;
}