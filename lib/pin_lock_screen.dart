import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  String? errorText;
  String storedPin = '1234';

  @override
  void initState() {
    super.initState();
    _loadStoredPin();
    _checkBiometric();
  }

  Future<void> _loadStoredPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPin = prefs.getString('app_pin') ?? '1234';
    });
  }

  Future<void> _checkBiometric() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      if (canCheck) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to unlock the app',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        if (authenticated) {
          _unlock();
        }
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
    }
  }

  void _unlock() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  void _validatePin() {
    if (_pinController.text == storedPin) {
      _unlock();
    } else {
      setState(() {
        errorText = 'Incorrect PIN. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock, size: 60, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                'Enter Security PIN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '4-digit PIN',
                  errorText: errorText,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validatePin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Unlock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
