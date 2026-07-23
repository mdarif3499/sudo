class FaqModel {
  final String? id;
  final String? question;
  final String? answer;

  FaqModel({
    this.id,
    this.question,
    this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
