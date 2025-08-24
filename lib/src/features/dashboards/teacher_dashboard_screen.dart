import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Dashboard')),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        padding: const EdgeInsets.all(16),
        children: [
          _NavTile(title: 'Attendance', icon: Icons.check_circle, onTap: () => context.go('/teacher/attendance')),
          _NavTile(title: 'Quizzes', icon: Icons.quiz, onTap: () => context.go('/teacher/quizzes')),
          _NavTile(title: 'Grades', icon: Icons.grade, onTap: () => context.go('/teacher/grades')),
          _NavTile(title: 'Content', icon: Icons.video_library, onTap: () => context.go('/teacher/content')),
          const _AnalyticsCard(),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _NavTile({required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(icon, size: 40), const SizedBox(height: 8), Text(title)],
          ),
        ),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard();
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Center(child: Text('Analytics coming soon')), // Placeholder for charts
    );
  }
}