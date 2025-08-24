import 'dart:async';
import 'package:flutter/material.dart';

class QuizTakeScreen extends StatefulWidget {
  final String quizId;
  const QuizTakeScreen({super.key, required this.quizId});

  @override
  State<QuizTakeScreen> createState() => _QuizTakeScreenState();
}

class _QuizTakeScreenState extends State<QuizTakeScreen> {
  int remaining = 300;
  Timer? timer;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => remaining = remaining - 1);
      if (remaining <= 0) {
        t.cancel();
        _submit();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quiz submitted (stub)')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz ${widget.quizId} - $remaining s')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Question: What is 2 + 2?', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          for (final e in ['3', '4', '5', '6'].asMap().entries)
            RadioListTile<int>(
              value: e.key,
              groupValue: selectedIndex,
              onChanged: (v) => setState(() => selectedIndex = v ?? -1),
              title: Text(e.value),
            ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _submit, child: const Text('Submit')),
        ],
      ),
    );
  }
}