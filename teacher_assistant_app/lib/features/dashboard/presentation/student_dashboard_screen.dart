import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/auth_provider.dart';

class StudentDashboardScreen extends ConsumerWidget {
  static const routeName = '/student-dashboard';
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Attendance: 92%'),
            SizedBox(height: 8),
            Text('Latest Quiz: 85%'),
            SizedBox(height: 8),
            Text('Overall Grade: B+'),
          ],
        ),
      ),
    );
  }
}