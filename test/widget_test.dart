import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fixed_app/main.dart'; // Import the correct file
import 'package:my_fixed_app/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_fixed_app/screens/login_screen.dart';

// Mock the AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  // Initialize Supabase client before running the tests
  setUp(() {
    // Mock Supabase initialization (you may want to use a mock client)
    Supabase.initialize(
      url: 'https://fake-url.supabase.co',
      anonKey: 'qwertyuioplkjhgfdszxcvbnmjhgfdsadf',
    );
  });

  testWidgets('MyApp renders LoginScreen', (WidgetTester tester) async {
    // Mock AuthService
    final mockAuthService = MockAuthService();

    // Build the widget using MyApp and pass the mock AuthService
    await tester.pumpWidget(MyApp(authService: mockAuthService));

    // Verify that LoginScreen is displayed
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
