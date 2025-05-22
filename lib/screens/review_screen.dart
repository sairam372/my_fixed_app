import 'package:flutter/material.dart';
import '../models/question_model.dart';

class ReviewScreen extends StatelessWidget {
  final List<Question> wrongQuestions;
  final Map<int, int> userAnswers;

  ReviewScreen({required this.wrongQuestions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Incorrect Questions')),
      body: ListView.builder(
        itemCount: wrongQuestions.length,
        itemBuilder: (context, index) {
          final q = wrongQuestions[index];
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
                  ...List.generate(q.options.length, (i) {
                    Color color;
                    if (i == q.correctAnswer) {
                      color = Colors.green;
                    } else if (i == userAnswers[q.id]) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(q.options[i], style: TextStyle(color: color)),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
