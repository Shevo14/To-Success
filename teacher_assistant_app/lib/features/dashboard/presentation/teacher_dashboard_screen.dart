import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../attendance/presentation/attendance_screen.dart';
import '../../quiz/presentation/quiz_create_screen.dart';
import '../../grades/presentation/grades_screen.dart';
import '../../content/presentation/content_screen.dart';

class TeacherDashboardScreen extends ConsumerWidget {
  static const routeName = '/teacher-dashboard';
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        actions: [
          IconButton(
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: () => ref.read(authStateProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _Tile(
            icon: Icons.checklist_rtl, label: 'Attendance',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AttendanceScreen())),
          ),
          _Tile(
            icon: Icons.quiz, label: 'Create Quiz',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizCreateScreen())),
          ),
          _Tile(
            icon: Icons.grade, label: 'Grades',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GradesScreen())),
          ),
          _Tile(
            icon: Icons.video_library, label: 'Content',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ContentScreen())),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(icon, size: 40), const SizedBox(height: 8), Text(label)],
          ),
        ),
      ),
    );
  }
}