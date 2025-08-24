import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  String? pickedFile;

  Future<void> _pick() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() => pickedFile = result.files.single.name);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Picked: ${result.files.single.name} (stub upload)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(pickedFile == null ? 'No file selected' : 'Selected: $pickedFile'),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: _pick, icon: const Icon(Icons.upload), label: const Text('Pick/Upload')),
          ],
        ),
      ),
    );
  }
}