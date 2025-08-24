import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/teacher_dashboard_screen.dart';
import '../../features/dashboard/presentation/student_dashboard_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/role_provider.dart';

class AppRouter {
  final WidgetRef ref;
  AppRouter(this.ref);

  String get initialRoute {
    final authState = ref.read(authStateProvider);
    if (authState.isLoggedIn) {
      final role = ref.read(userRoleProvider);
      return role == UserRole.teacher ? TeacherDashboardScreen.routeName : StudentDashboardScreen.routeName;
    }
    return LoginScreen.routeName;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case TeacherDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TeacherDashboardScreen());
      case StudentDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const StudentDashboardScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));