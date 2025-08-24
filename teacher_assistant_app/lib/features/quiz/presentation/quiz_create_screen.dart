import 'package:flutter/material.dart';

class QuizCreateScreen extends StatefulWidget {
  const QuizCreateScreen({super.key});

  @override
  State<QuizCreateScreen> createState() => _QuizCreateScreenState();
}

class _QuizCreateScreenState extends State<QuizCreateScreen> {
  final List<Map<String, dynamic>> questions = [];
  final titleController = TextEditingController();

  void _addQuestion() {
    setState(() {
      questions.add({'text': 'New question', 'type': 'mcq', 'options': ['A', 'B', 'C', 'D'], 'answer': 0});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Quiz Title')),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Card(
                    child: ListTile(
                      title: Text(q['text'] as String),
                      subtitle: Text('Type: ${q['type']}'),
                      trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => setState(() => questions.removeAt(index))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(onPressed: _addQuestion, child: const Icon(Icons.add)),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quiz saved (stub)')));
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}