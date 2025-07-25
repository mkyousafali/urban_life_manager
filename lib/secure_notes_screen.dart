import 'package:flutter/material.dart';

class SecureNotesScreen extends StatefulWidget {
  const SecureNotesScreen({super.key});

  @override
  State<SecureNotesScreen> createState() => _SecureNotesScreenState();
}

class _SecureNotesScreenState extends State<SecureNotesScreen> {
  final List<Map<String, dynamic>> secureNotes = [];
  bool showPasswords = false;

  void _showAddSecureNoteDialog() {
    final titleController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Secure Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Service / Device Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username / ID'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
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
              if (titleController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  secureNotes.add({
                    'title': titleController.text,
                    'username': usernameController.text,
                    'password': passwordController.text,
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

  Widget _buildNoteTile(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(item['title']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item['username'].toString().isNotEmpty)
              Text("ID: ${item['username']}"),
            Text(
              "Password: ${showPasswords ? item['password'] : '•••••••'}",
              style: const TextStyle(letterSpacing: 2),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Notes'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(showPasswords ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                showPasswords = !showPasswords;
              });
            },
          ),
        ],
      ),
      body: secureNotes.isEmpty
          ? const Center(child: Text('No secure notes yet.'))
          : ListView.builder(
        itemCount: secureNotes.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = secureNotes[index];
          return _buildNoteTile(item);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _showAddSecureNoteDialog,
        child: const Icon(Icons.lock),
      ),
    );
  }
}
