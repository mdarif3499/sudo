class GroupDetailsModel {
  final GroupData? group;
  final int? currentPeriod;
  final int? currentCycle;
  final dynamic currentReceiver;
  final dynamic progress;
  final num? currentPeriodExpectedAmount;
  final num? currentPeriodCollectedAmount;
  final bool? isCurrentReceiver;
  final bool? hasPaidCurrentPeriod;
  final int? totalPeriods;

  GroupDetailsModel({
    this.group,
    this.currentPeriod,
    this.currentCycle,
    this.currentReceiver,
    this.progress,
    this.currentPeriodExpectedAmount,
    this.currentPeriodCollectedAmount,
    this.isCurrentReceiver,
    this.hasPaidCurrentPeriod,
    this.totalPeriods,
  });

  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailsModel(
      group: json['group'] != null ? GroupData.fromJson(json['group']) : null,
      currentPeriod: json['currentPeriod'],
      currentCycle: json['currentCycle'],
      currentReceiver: json['currentReceiver'],
      progress: json['progress'],
      currentPeriodExpectedAmount: json['currentPeriodExpectedAmount'],
      currentPeriodCollectedAmount: json['currentPeriodCollectedAmount'],
      isCurrentReceiver: json['isCurrentReceiver'],
      hasPaidCurrentPeriod: json['hasPaidCurrentPeriod'],
      totalPeriods: json['totalPeriods'],
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
  final List<Member>? members;
  final List<RotationSchedule>? rotationSchedule;
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
    this.rotationSchedule,
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
      members: json['members'] != null 
          ? List<Member>.from(json['members'].map((x) => Member.fromJson(x))) 
          : [],
      rotationSchedule: json['rotationSchedule'] != null
          ? List<RotationSchedule>.from(json['rotationSchedule'].map((x) => RotationSchedule.fromJson(x)))
          : [],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

class Member {
  final String? id;
  final String? email;
  final String? fullName;
  final String? image;

  Member({this.id, this.email, this.fullName, this.image});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      fullName: json['fullName'],
      image: json['image'],
    );
  }
}

class Admin {
  final String? id;
  final String? email;
  final String? fullName;
  final String? image;

  Admin({this.id, this.email, this.fullName, this.image});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      fullName: json['fullName'],
      image: json['image'],
    );
  }
}

class RotationSchedule {
  final String? id;
  final int? periodNumber;
  final int? cycleNumber;
  final Member? receiver;
  final String? payoutDate;
  final String? status;

  RotationSchedule({
    this.id,
    this.periodNumber,
    this.cycleNumber,
    this.receiver,
    this.payoutDate,
    this.status,
  });

  factory RotationSchedule.fromJson(Map<String, dynamic> json) {
    return RotationSchedule(
      id: json['_id'],
      periodNumber: json['periodNumber'],
      cycleNumber: json['cycleNumber'],
      receiver: json['receiverId'] != null ? Member.fromJson(json['receiverId']) : null,
      payoutDate: json['payoutDate'],
      status: json['status'],
    );
  }
}
