import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../auth_gate.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthService? authService;

  const LoginScreen({super.key, this.authService});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth =
        widget.authService ?? AuthService(client: Supabase.instance.client);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            // Login Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SignUpScreen(authService: auth),
                  ),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),

            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in both fields')),
                  );
                  return;
                }

                try {
                  final response = await Supabase.instance.client.auth
                      .signInWithPassword(email: email, password: password);

                  final user = response.user;

                  if (user != null) {
                    print("Login successful: ${response.user?.email}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );
                    // Navigate to another screen if needed
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AuthGate(authService: auth),
                      ),

                      (route) => false,
                    );
                  } else {
                    print("Login failed: No user returned");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login failed: Invalid credentials'),
                      ),
                    );
                  }
                } catch (e) {
                  print("Login error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login error: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Login'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
