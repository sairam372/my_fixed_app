import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'screens/home_screen.dart'; // <-- Import your actual Home screen
import 'screens/login_screen.dart'; // <-- Import your Login screen

class AuthGate extends StatelessWidget {
  final AuthService authService;

  const AuthGate({required this.authService, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return HomeScreen(); // ✅ Show the actual HomeScreen
        } else {
          return LoginScreen(authService: authService); // ✅ Show LoginScreen
        }
      },
    );
  }
}
