import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});
  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final items = <_Content>[
    _Content(title: 'Lecture 1', type: 'video/mp4'),
    _Content(title: 'Slides Week 1', type: 'application/pdf'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final c = items[i];
          return Card(
            child: ListTile(
              leading: Icon(c.type.startsWith('video') ? Icons.movie : Icons.picture_as_pdf),
              title: Text(c.title),
              subtitle: Text(c.type),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open content (stub)'))),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload (stub)'))),
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}

class _Content {
  final String title;
  final String type;
  _Content({required this.title, required this.type});
}