import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinChangeScreen extends StatefulWidget {
  const PinChangeScreen({super.key});

  @override
  State<PinChangeScreen> createState() => _PinChangeScreenState();
}

class _PinChangeScreenState extends State<PinChangeScreen> {
  final TextEditingController oldPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  String? errorText;
  String storedPin = '1234';

  @override
  void initState() {
    super.initState();
    _loadStoredPin();
  }

  Future<void> _loadStoredPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPin = prefs.getString('app_pin') ?? '1234';
    });
  }

  Future<void> _saveNewPin(String newPin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_pin', newPin);
  }

  void _changePin() {
    if (oldPinController.text != storedPin) {
      setState(() {
        errorText = 'Old PIN is incorrect';
      });
    } else if (newPinController.text != confirmPinController.text) {
      setState(() {
        errorText = 'New PINs do not match';
      });
    } else {
      _saveNewPin(newPinController.text);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN changed successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change PIN'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: oldPinController,
              obscureText: true,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'Old PIN'),
            ),
            TextField(
              controller: newPinController,
              obscureText: true,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'New PIN'),
            ),
            TextField(
              controller: confirmPinController,
              obscureText: true,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'Confirm New PIN'),
            ),
            if (errorText != null)
              Text(errorText!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePin,
              child: const Text('Change PIN'),
            ),
          ],
        ),
      ),
    );
  }
}
