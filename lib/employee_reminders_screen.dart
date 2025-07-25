import 'package:flutter/material.dart';

class EmployeeRemindersScreen extends StatefulWidget {
  const EmployeeRemindersScreen({super.key});

  @override
  State<EmployeeRemindersScreen> createState() =>
      _EmployeeRemindersScreenState();
}

class _EmployeeRemindersScreenState extends State<EmployeeRemindersScreen> {
  final List<Map<String, String>> reminders = [];

  void _showAddReminderDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController taskController = TextEditingController();

    TimeOfDay selectedTime = TimeOfDay.now();
    DateTime selectedDate = DateTime.now();
    String repeatOption = 'None';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Employee Reminder'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration:
                const InputDecoration(labelText: 'Employee Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: taskController,
                decoration: const InputDecoration(labelText: 'Task / Note'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                  const Spacer(),
                  TextButton(
                    child: const Text("Pick Date"),
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
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: 8),
                  Text(selectedTime.format(context)),
                  const Spacer(),
                  TextButton(
                    child: const Text("Pick Time"),
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: repeatOption,
                items: ['None', 'Daily', 'Weekly', 'Monthly', 'Yearly']
                    .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      repeatOption = value;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Repeat'),
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
                  taskController.text.isNotEmpty) {
                setState(() {
                  reminders.add({
                    'name': nameController.text,
                    'task': taskController.text,
                    'date':
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    'time': selectedTime.format(context),
                    'repeat': repeatOption
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
        title: const Text('Employee Reminders'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: reminders.isEmpty
          ? const Center(
        child: Text(
          'No employee reminders yet.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: reminders.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = reminders[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("${item['name']} – ${item['task']}"),
              subtitle: Text(
                "📅 ${item['date']} at ⏰ ${item['time']} • Repeat: ${item['repeat']}",
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: _showAddReminderDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
