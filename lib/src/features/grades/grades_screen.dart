import 'package:flutter/material.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});
  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final items = <_Grade>[
    _Grade(title: 'Assignment 1', score: 85, maxScore: 100),
    _Grade(title: 'Quiz 1', score: 9, maxScore: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grades')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final g = items[i];
          return Card(
            child: ListTile(
              title: Text(g.title),
              trailing: Text('${g.score}/${g.maxScore}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add grade (stub)')),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Grade {
  final String title;
  final num score;
  final num maxScore;
  _Grade({required this.title, required this.score, required this.maxScore});
}