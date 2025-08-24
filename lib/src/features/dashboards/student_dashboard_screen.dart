import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Card(title: 'Attendance', value: '85%'),
          _Card(title: 'Average Grade', value: 'B+'),
          _Card(title: 'Recent Quiz', value: '92/100'),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String value;
  const _Card({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title, style: Theme.of(context).textTheme.titleMedium), Text(value)],
        ),
      ),
    );
  }
}