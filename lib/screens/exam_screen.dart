import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/supabase_service.dart';
import 'result_screen.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final SupabaseService _service = SupabaseService();
  List<Question> _questions = [];
  Map<int, int> _answers = {}; // questionId -> selectedOptionIndex
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await _service.fetchQuestions();
    setState(() {
      _questions = questions;
      _loading = false;
    });
  }

  void _submitExam() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => ResultScreen(questions: _questions, userAnswers: _answers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Physics Exam')),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final q = _questions[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${q.questionNumber}. ${q.question}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // ✅ Show diagram if diagramUrl is available
                  if (q.diagramUrl != null && q.diagramUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        q.diagramUrl!,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Text('Could not load image'),
                      ),
                    ),

                  ...List.generate(q.options.length, (optIndex) {
                    return RadioListTile<int>(
                      title: Text(q.options[optIndex]),
                      value: optIndex,
                      groupValue: _answers[q.id],
                      onChanged: (val) {
                        setState(() {
                          _answers[q.id] = val!;
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitExam,
        child: Icon(Icons.check),
        tooltip: 'Submit Exam',
      ),
    );
  }
}
