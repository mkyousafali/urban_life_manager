import 'package:flutter/material.dart';
import 'income_screen.dart';
import 'expenses_screen.dart';
import 'lent_borrowed_screen.dart';
import 'pooled_fund_screen.dart';
import 'budget_screen.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {'icon': Icons.attach_money, 'label': 'Income'},
      {'icon': Icons.money_off, 'label': 'Expenses'},
      {'icon': Icons.swap_horiz, 'label': 'Lent / Borrowed'},
      {'icon': Icons.account_balance, 'label': 'Pooled Fund'},
      {'icon': Icons.bar_chart, 'label': 'Budget Maker'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Manager'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: sections.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = sections[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(item['icon'], color: Colors.deepPurple, size: 28),
              title: Text(
                item['label'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                if (item['label'] == 'Budget Maker') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BudgetScreen()),
                  );
                }

                if (item['label'] == 'Pooled Fund') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PooledFundScreen()),
                  );
                }

                if (item['label'] == 'Lent / Borrowed') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LentBorrowedScreen()),
                  );
                }

                if (item['label'] == 'Expenses') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExpensesScreen()),
                  );
                }

                if (item['label'] == 'Income') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IncomeScreen(),
                    ),
                  );
                }

                // Add more navigation logic for other sections later
              },
            ),
          );
        },
      ),
    );
  }
}
