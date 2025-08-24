import 'dart:async';
import 'package:flutter/material.dart';

class QuizTakeScreen extends StatefulWidget {
  const QuizTakeScreen({super.key});

  @override
  State<QuizTakeScreen> createState() => _QuizTakeScreenState();
}

class _QuizTakeScreenState extends State<QuizTakeScreen> {
  int remainingSeconds = 60;
  Timer? timer;
  int selected = -1;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds <= 1) {
        _submit();
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _submit() {
    timer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Submitted (stub)')));
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz (${remainingSeconds}s)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question: 2 + 2 = ?'),
            const SizedBox(height: 12),
            for (final entry in ['3', '4', '5', '6'].asMap().entries)
              RadioListTile<int>(
                value: entry.key,
                groupValue: selected,
                title: Text(entry.value),
                onChanged: (v) => setState(() => selected = v ?? -1),
              ),
            const Spacer(),
            FilledButton.icon(onPressed: _submit, icon: const Icon(Icons.send), label: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}