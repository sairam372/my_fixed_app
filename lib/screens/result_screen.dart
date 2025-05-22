import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'review_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, int> userAnswers;

  ResultScreen({required this.questions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    List<Question> wrongQuestions = [];

    for (var q in questions) {
      if (userAnswers[q.id] == q.correctAnswer) {
        correct++;
      } else {
        wrongQuestions.add(q);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Exam Result')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'You scored $correct out of ${questions.length}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ReviewScreen(
                          wrongQuestions: wrongQuestions,
                          userAnswers: userAnswers,
                        ),
                  ),
                );
              },
              child: Text('Review Incorrect Questions'),
            ),
          ],
        ),
      ),
    );
  }
}
