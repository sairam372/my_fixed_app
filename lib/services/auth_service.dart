import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;

  // Don't call Supabase.instance directly here
  AuthService({required this.client});

  Future<bool> isLoggedIn() async {
    final user = client.auth.currentUser;
    return user != null;
  }
}
