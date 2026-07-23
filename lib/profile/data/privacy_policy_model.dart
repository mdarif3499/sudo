class PrivacyPolicyModel {
  final String? id;
  final String? content;
  final String? type;

  PrivacyPolicyModel({
    this.id,
    this.content,
    this.type,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      id: json['_id'],
      content: json['content'],
      type: json['type'],
    );
  }
}
