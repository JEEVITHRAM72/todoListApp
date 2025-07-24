import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _loading = false;
  String? _error;

  Future<void> _handleSignIn() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TaskListScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _error = 'Sign in failed. Please try again.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Todo List',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/google_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 48),
                        textStyle: const TextStyle(fontSize: 18),
                        elevation: 2,
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onPressed: _handleSignIn,
                    ),
            ],
          ),
        ),
      ),
    );
  }
} 