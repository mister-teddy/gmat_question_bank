class Question {
  final String src;
  final String question;
  final List<String> explanations;

  Question(
      {required this.src, required this.question, required this.explanations});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      src: json['src'],
      question: json['question'],
      explanations: List<String>.from(json['explainations']),
    );
  }
}
