import 'package:flutter/material.dart';
import 'employee_reminders_screen.dart';
import 'personal_reminders_screen.dart';
import 'family_reminders_screen.dart';

class RemindersHubScreen extends StatelessWidget {
  const RemindersHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'label': 'Employee Reminders', 'widget': const EmployeeRemindersScreen()},
      {'label': 'Personal Reminders', 'widget': const PersonalRemindersScreen()},
      {'label': 'Family Reminders', 'widget': const FamilyRemindersScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 10),
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
