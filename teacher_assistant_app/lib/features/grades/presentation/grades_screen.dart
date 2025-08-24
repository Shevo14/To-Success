import 'package:flutter/material.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final grades = [
      {'title': 'Assignment 1', 'grade': 85},
      {'title': 'Quiz 1', 'grade': 92},
      {'title': 'Midterm', 'grade': 78},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Grades')),
      body: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          final g = grades[index];
          return ListTile(
            title: Text(g['title'] as String),
            subtitle: LinearProgressIndicator(value: (g['grade'] as int) / 100),
            trailing: Text('${g['grade']}%'),
          );
        },
      ),
    );
  }
}