class GroupDetailsModel {
  final GroupData? group;
  final int? currentPeriod;
  final int? currentCycle;
  final dynamic currentReceiver;
  final dynamic progress;
  final bool? isCurrentReceiver;
  final bool? hasPaidCurrentPeriod;

  GroupDetailsModel({
    this.group,
    this.currentPeriod,
    this.currentCycle,
    this.currentReceiver,
    this.progress,
    this.isCurrentReceiver,
    this.hasPaidCurrentPeriod,
  });

  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailsModel(
      group: json['group'] != null ? GroupData.fromJson(json['group']) : null,
      currentPeriod: json['currentPeriod'],
      currentCycle: json['currentCycle'],
      currentReceiver: json['currentReceiver'],
      progress: json['progress'],
      isCurrentReceiver: json['isCurrentReceiver'],
      hasPaidCurrentPeriod: json['hasPaidCurrentPeriod'],
    );
  }
}

class GroupData {
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
  final List<String>? members;
  final String? status;
  final DateTime? createdAt;

  GroupData({
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
    this.createdAt,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
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
      members: json['members'] != null ? List<String>.from(json['members']) : [],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
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
