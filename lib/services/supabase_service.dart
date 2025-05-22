import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/question_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Question>> fetchQuestions() async {
    final response = await _client
        .from('physics_questions')
        .select()
        .order('question_number', ascending: true);

    // Check if there's an error
    if (response is PostgrestException) {
      print('Error fetching questions: ${response.message}');
      return [];
    }

    // If response is not a PostgrestException, it should be the data itself
    if (response == null || response is! List) {
      print('Unexpected response format.');
      return [];
    }

    try {
      final data = response as List<dynamic>;
      return data.map((q) => Question.fromMap(q)).toList();
    } catch (e) {
      print('Error parsing questions: $e');
      return [];
    }
  }
}
