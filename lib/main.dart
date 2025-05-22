import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/exam_screen.dart';
import 'screens/result_screen.dart';
import 'screens/review_screen.dart';
import 'services/auth_service.dart';
import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yoneqfftqxxnfuyaubzc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlvbmVxZmZ0cXh4bmZ1eWF1YnpjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5MTg0NjIsImV4cCI6MjA2MTQ5NDQ2Mn0.EK33gAl5cbcRVHm2btmQCePkIs5ar8DVLf46PSZVaHk',
  );

  final authService = AuthService(client: Supabase.instance.client); // ✅ fixed

  runApp(MyApp(authService: authService)); // ✅ passes to MyApp
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Exam App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthGate(authService: authService),
        '/login': (context) => LoginScreen(authService: authService),
        '/home': (context) => const HomeScreen(),
        '/exam': (context) => ExamScreen(),
        // These routes are used only if no arguments are passed
        // Normally you pass arguments via MaterialPageRoute
      },
    );
  }
}
