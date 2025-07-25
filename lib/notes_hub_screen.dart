import 'package:flutter/material.dart';
import 'employee_notes_screen.dart';
import 'personal_notes_screen.dart';
import 'family_notes_screen.dart';
import 'secure_notes_screen.dart';

class NotesHubScreen extends StatelessWidget {
  const NotesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'label': 'Employee Notes', 'widget': const EmployeeNotesScreen()},
      {'label': 'Personal Notes', 'widget': const PersonalNotesScreen()},
      {'label': 'Family Notes', 'widget': const FamilyNotesScreen()},
      {'label': 'Secure Notes', 'widget': const SecureNotesScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            child: ListTile(
              title: Text(item['label']),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['widget']),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
