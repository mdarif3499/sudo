class PeriodHistoryModel {
  final String? groupId;
  final int? periodNumber;
  final int? cycleNumber;
  final String? payoutDate;
  final String? payoutStatus;
  final List<PeriodMember>? members;

  PeriodHistoryModel({
    this.groupId,
    this.periodNumber,
    this.cycleNumber,
    this.payoutDate,
    this.payoutStatus,
    this.members,
  });

  factory PeriodHistoryModel.fromJson(Map<String, dynamic> json) {
    return PeriodHistoryModel(
      groupId: json['groupId'],
      periodNumber: json['periodNumber'],
      cycleNumber: json['cycleNumber'],
      payoutDate: json['payoutDate'],
      payoutStatus: json['payoutStatus'],
      members: json['members'] != null
          ? List<PeriodMember>.from(
              json['members'].map((x) => PeriodMember.fromJson(x)))
          : [],
    );
  }
}

class PeriodMember {
  final MemberInfo? member;
  final String? status;
  final int? amount;
  final String? paymentDate;
  final String? transactionId;

  PeriodMember({
    this.member,
    this.status,
    this.amount,
    this.paymentDate,
    this.transactionId,
  });

  factory PeriodMember.fromJson(Map<String, dynamic> json) {
    return PeriodMember(
      member: json['member'] != null ? MemberInfo.fromJson(json['member']) : null,
      status: json['status'],
      amount: json['amount'],
      paymentDate: json['paymentDate'],
      transactionId: json['transactionId'],
    );
  }
}

class MemberInfo {
  final String? id;
  final String? fullName;
  final String? email;
  final String? image;

  MemberInfo({this.id, this.fullName, this.email, this.image});

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
    );
  }
}
