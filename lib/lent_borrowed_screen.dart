import 'package:flutter/material.dart';

class LentBorrowedScreen extends StatefulWidget {
  const LentBorrowedScreen({super.key});

  @override
  State<LentBorrowedScreen> createState() => _LentBorrowedScreenState();
}

class _LentBorrowedScreenState extends State<LentBorrowedScreen> {
  final List<Map<String, String>> records = [];

  void _showAddRecordDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController reasonController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Lent / Borrowed'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(labelText: 'Reason'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text("Change"),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  )
                ],
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
                  amountController.text.isNotEmpty &&
                  reasonController.text.isNotEmpty) {
                setState(() {
                  records.add({
                    'name': nameController.text,
                    'amount': amountController.text,
                    'reason': reasonController.text,
                    'date':
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
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
        title: const Text('Lent / Borrowed'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: records.isEmpty
          ? const Center(
        child: Text(
          'No records yet.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: records.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = records[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("${item['name']} - ₹${item['amount']}"),
              subtitle: Text("${item['reason']} • ${item['date']}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _showAddRecordDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
