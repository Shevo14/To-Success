import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<_Student> students = [
    _Student(id: '1', name: 'Alice'),
    _Student(id: '2', name: 'Bob'),
    _Student(id: '3', name: 'Charlie'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return ListTile(
            title: Text(s.name),
            trailing: DropdownButton<String>(
              value: s.status,
              items: const [
                DropdownMenuItem(value: 'present', child: Text('Present')),
                DropdownMenuItem(value: 'absent', child: Text('Absent')),
                DropdownMenuItem(value: 'late', child: Text('Late')),
              ],
              onChanged: (v) => setState(() => s.status = v ?? 'present'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance saved (stub)')));
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}

class _Student {
  final String id;
  final String name;
  String status;
  _Student({required this.id, required this.name, this.status = 'present'});
}