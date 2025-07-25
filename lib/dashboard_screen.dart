import 'package:flutter/material.dart';
import 'finance_screen.dart';
import 'reminders_hub_screen.dart'; // <-- Updated to use reminders hub
import 'notes_hub_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.account_balance_wallet, 'label': 'Finance'},
      {'icon': Icons.alarm, 'label': 'Reminders'},
      {'icon': Icons.note_alt, 'label': 'Notes'},
      {'icon': Icons.email, 'label': 'Email'},
      {'icon': Icons.chat_bubble, 'label': 'WhatsApp'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Urban Life Manager'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: items.map((item) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade50,
                foregroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (item['label'] == 'Settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                }

                if (item['label'] == 'Notes') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotesHubScreen()),
                  );
                }

                if (item['label'] == 'Reminders') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RemindersHubScreen()),
                  );
                }

                if (item['label'] == 'Finance') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FinanceScreen()),
                  );
                }

                // You can add more buttons here later like Notes, Email, WhatsApp, etc.
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 36),
                  const SizedBox(height: 10),
                  Text(item['label'], style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
