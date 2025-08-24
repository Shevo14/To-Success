import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<String, String> attendance = {
    'Alice': 'present',
    'Bob': 'absent',
    'Charlie': 'late',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: ListView(
        children: attendance.entries.map((e) {
          return ListTile(
            title: Text(e.key),
            trailing: DropdownButton<String>(
              value: e.value,
              items: const [
                DropdownMenuItem(value: 'present', child: Text('Present')),
                DropdownMenuItem(value: 'absent', child: Text('Absent')),
                DropdownMenuItem(value: 'late', child: Text('Late')),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() => attendance[e.key] = v);
              },
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance saved (stub)')));
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
    );
  }
}