import 'package:flutter/material.dart';

class PooledFundScreen extends StatefulWidget {
  const PooledFundScreen({super.key});

  @override
  State<PooledFundScreen> createState() => _PooledFundScreenState();
}

class _PooledFundScreenState extends State<PooledFundScreen> {
  final List<Map<String, String>> fundList = [];

  void _showAddFundDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController monthController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Member Contribution'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Member Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount Paid'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: monthController,
                decoration: const InputDecoration(labelText: 'Month'),
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
                  monthController.text.isNotEmpty) {
                setState(() {
                  fundList.add({
                    'name': nameController.text,
                    'amount': amountController.text,
                    'month': monthController.text,
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
        title: const Text('Pooled Fund'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: fundList.isEmpty
          ? const Center(
        child: Text(
          'No contributions yet.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: fundList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = fundList[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("${item['name']} paid ₹${item['amount']}"),
              subtitle: Text("Month: ${item['month']} • ${item['date']}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _showAddFundDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
