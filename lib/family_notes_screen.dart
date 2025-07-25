import 'package:flutter/material.dart';

class FamilyNotesScreen extends StatefulWidget {
  const FamilyNotesScreen({super.key});

  @override
  State<FamilyNotesScreen> createState() => _FamilyNotesScreenState();
}

class _FamilyNotesScreenState extends State<FamilyNotesScreen> {
  final List<Map<String, String>> notes = [];

  void _showAddNoteDialog() {
    final nameController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Family Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Family Member'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'Note'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  noteController.text.isNotEmpty) {
                setState(() {
                  notes.add({
                    'name': nameController.text,
                    'note': noteController.text,
                  });
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Notes'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No family notes yet.'))
          : ListView.builder(
        itemCount: notes.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = notes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(item['name']!),
              subtitle: Text(item['note']!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _showAddNoteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
