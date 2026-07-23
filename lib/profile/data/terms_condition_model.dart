class TermsConditionModel {
  final String? id;
  final String? content;
  final String? type;

  TermsConditionModel({
    this.id,
    this.content,
    this.type,
  });

  factory TermsConditionModel.fromJson(Map<String, dynamic> json) {
    return TermsConditionModel(
      id: json['_id'],
      content: json['content'],
      type: json['type'],
    );
  }
}
