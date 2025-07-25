import 'package:flutter/material.dart';
import 'main.dart';
import 'pin_change_screen.dart';
import 'pin_lock_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String displayName = 'Yousafali';
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = displayName;
  }

  void _saveName() {
    setState(() {
      displayName = nameController.text;
    });
    Navigator.pop(context);
  }

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Your Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveName,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _openPinChangeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PinChangeScreen()),
    );
  }

  void _logoutAndGoToPin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PinLockScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Display Name'),
            subtitle: Text(displayName),
            trailing: const Icon(Icons.edit),
            onTap: _showEditNameDialog,
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              MyApp.of(context)?.toggleTheme(value);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Change Security PIN'),
            subtitle: const Text('Tap to update your 4-digit PIN'),
            trailing: const Icon(Icons.lock_outline),
            onTap: _openPinChangeScreen,
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
            onTap: _logoutAndGoToPin,
          ),
        ],
      ),
    );
  }
}
