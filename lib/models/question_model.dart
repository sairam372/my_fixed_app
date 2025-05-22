class Question {
  final int id;
  final int questionNumber;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String? diagramUrl; // Add this

  Question({
    required this.id,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.diagramUrl,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      questionNumber: map['question_number'],
      question: map['question_text'],
      options: [
        map['option_1'],
        map['option_2'],
        map['option_3'],
        map['option_4'],
      ],
      correctAnswer: map['correct_answer'] - 1,
      diagramUrl: map['diagram_url'], // Map this too
    );
  }
}
