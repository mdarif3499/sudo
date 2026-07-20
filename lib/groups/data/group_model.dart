class GroupModel {
  final String? id;
  final String name;
  final String status;
  final String visibility;
  final int membersCount;
  final dynamic progress;
  final int poolTotal;
  final int myShare;
  final String? nextDue;
  final int currentCycle;
  final int totalCycles;
  final String paymentFrequency;
  final DateTime? startDate;

  GroupModel({
    this.id,
    required this.name,
    required this.status,
    required this.visibility,
    required this.membersCount,
    required this.progress,
    required this.poolTotal,
    required this.myShare,
    this.nextDue,
    required this.currentCycle,
    required this.totalCycles,
    required this.paymentFrequency,
    this.startDate,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['_id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      visibility: json['visibility'] ?? '',
      membersCount: json['membersCount'] ?? 0,
      progress: json['progress'] ?? 0.0,
      poolTotal: json['poolTotal'] ?? 0,
      myShare: json['myShare'] ?? 0,
      nextDue: json['nextDue'],
      currentCycle: json['currentCycle'] ?? 1,
      totalCycles: json['totalCycles'] ?? 1,
      paymentFrequency: json['paymentFrequency'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
    );
  }
}

class MemberModel {
  final String name;
  final String amount;
  final String status;
  final bool isPaid;
  final String initials;

  MemberModel({
    required this.name,
    required this.amount,
    required this.status,
    required this.isPaid,
    required this.initials,
  });
}
