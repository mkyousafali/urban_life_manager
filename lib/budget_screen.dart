import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double budget = 0;
  double spent = 0;

  final TextEditingController budgetController = TextEditingController();
  final TextEditingController spentController = TextEditingController();

  double get percentageUsed {
    if (budget == 0) return 0;
    return (spent / budget).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final percent = (percentageUsed * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Maker'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Set Your Monthly Budget:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter budget amount',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter Total Spent So Far:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: spentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter total spent',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  budget = double.tryParse(budgetController.text) ?? 0;
                  spent = double.tryParse(spentController.text) ?? 0;
                });
              },
              child: const Text('Update Budget'),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: percentageUsed,
              backgroundColor: Colors.grey.shade300,
              color: percentageUsed > 1
                  ? Colors.red
                  : percentageUsed > 0.75
                  ? Colors.orange
                  : Colors.green,
              minHeight: 20,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Used: ₹${spent.toStringAsFixed(0)} of ₹${budget.toStringAsFixed(0)}  ($percent%)',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
