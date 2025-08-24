import 'package:flutter/material.dart';

class QuizCreatorScreen extends StatefulWidget {
  const QuizCreatorScreen({super.key});
  @override
  State<QuizCreatorScreen> createState() => _QuizCreatorScreenState();
}

class _QuizCreatorScreenState extends State<QuizCreatorScreen> {
  final titleCtrl = TextEditingController();
  final durationCtrl = TextEditingController(text: '300');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 8),
            TextField(controller: durationCtrl, decoration: const InputDecoration(labelText: 'Duration (sec)'), keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quiz saved (stub)')));
              },
              child: const Text('Save Quiz'),
            )
          ],
        ),
      ),
    );
  }
}