import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/dashboards/teacher_dashboard_screen.dart';
import '../../features/dashboards/student_dashboard_screen.dart';
import '../../features/attendance/attendance_screen.dart';
import '../../features/quizzes/quiz_creator_screen.dart';
import '../../features/quizzes/quiz_take_screen.dart';
import '../../features/grades/grades_screen.dart';
import '../../features/content/content_screen.dart';
import '../providers/firebase_providers.dart';
import '../firebase/firebase_init.dart';

final routerKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final appRouterProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(routerKeyProvider);
  final initAsync = ref.watch(firebaseInitProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final userRole = ref.watch(userRoleProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    redirect: (context, state) {
      final isInitialized = initAsync.asData != null;
      if (!isInitialized) {
        return state.matchedLocation == '/splash' ? null : '/splash';
      }

      final user = firebaseAuth.currentUser;
      final isLoggingIn = state.matchedLocation == '/login';

      if (user == null) {
        return isLoggingIn ? null : '/login';
      }

      // User logged in, route by role
      final role = userRole.valueOrNull;
      if (role == null) {
        // Stay on current route until role loads
        return null;
      }

      final isTeacher = role == 'teacher';
      final isStudent = role == 'student';

      if (isTeacher && state.matchedLocation.startsWith('/teacher')) return null;
      if (isStudent && state.matchedLocation.startsWith('/student')) return null;

      return isTeacher ? '/teacher' : '/student';
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const _SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/teacher',
        builder: (_, __) => const TeacherDashboardScreen(),
        routes: [
          GoRoute(
            path: 'attendance',
            builder: (_, __) => const AttendanceScreen(),
          ),
          GoRoute(
            path: 'quizzes',
            builder: (_, __) => const QuizCreatorScreen(),
          ),
          GoRoute(
            path: 'grades',
            builder: (_, __) => const GradesScreen(),
          ),
          GoRoute(
            path: 'content',
            builder: (_, __) => const ContentScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/student',
        builder: (_, __) => const StudentDashboardScreen(),
        routes: [
          GoRoute(
            path: 'quiz/:quizId',
            builder: (_, state) => QuizTakeScreen(quizId: state.pathParameters['quizId']!),
          ),
        ],
      ),
    ],
  );
});

class _SplashScreen extends ConsumerWidget {
  const _SplashScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(firebaseInitProvider);
    return Scaffold(
      body: Center(
        child: init.when(
          data: (_) => const CircularProgressIndicator(),
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Init error: $e'),
        ),
      ),
    );
  }
}