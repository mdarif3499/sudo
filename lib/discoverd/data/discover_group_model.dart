class DiscoverGroupModel {
  final String? id;
  final String? name;
  final Admin? admin;
  final int? contributionAmount;
  final int? targetPoolAmount;
  final int? targetedMembers;
  final String? paymentFrequency;
  final int? totalCycles;
  final String? startDate;
  final String? visibility;
  final List<Admin>? members;
  final String? status;

  DiscoverGroupModel({
    this.id,
    this.name,
    this.admin,
    this.contributionAmount,
    this.targetPoolAmount,
    this.targetedMembers,
    this.paymentFrequency,
    this.totalCycles,
    this.startDate,
    this.visibility,
    this.members,
    this.status,
  });

  factory DiscoverGroupModel.fromJson(Map<String, dynamic> json) {
    return DiscoverGroupModel(
      id: json['_id'],
      name: json['name'],
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      contributionAmount: json['contributionAmount'],
      targetPoolAmount: json['targetPoolAmount'],
      targetedMembers: json['targetedMembers'],
      paymentFrequency: json['paymentFrequency'],
      totalCycles: json['totalCycles'],
      startDate: json['startDate'],
      visibility: json['visibility'],
      members: json['members'] != null
          ? List<Admin>.from(json['members'].map((x) => Admin.fromJson(x)))
          : [],
      status: json['status'],
    );
  }
}

class Admin {
  final String? id;
  final String? email;
  final String? fullName;

  Admin({this.id, this.email, this.fullName});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }
}
