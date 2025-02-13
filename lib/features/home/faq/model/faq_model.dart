class Faq {
  final String id;
  final String question;
  final String answer;
  bool isExpanded;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
