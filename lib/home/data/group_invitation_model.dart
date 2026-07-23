class GroupInvitationModel {
  final String? id;
  final InvitationGroup? group;
  final InvitationSender? sender;
  final String? receiverId;
  final String? status;
  final String? createdAt;

  GroupInvitationModel({
    this.id,
    this.group,
    this.sender,
    this.receiverId,
    this.status,
    this.createdAt,
  });

  factory GroupInvitationModel.fromJson(Map<String, dynamic> json) {
    return GroupInvitationModel(
      id: json['_id'],
      group: json['groupId'] != null ? InvitationGroup.fromJson(json['groupId']) : null,
      sender: json['senderId'] != null ? InvitationSender.fromJson(json['senderId']) : null,
      receiverId: json['receiverId'],
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }
}

class InvitationGroup {
  final String? id;
  final String? name;
  final int? contributionAmount;
  final int? targetPoolAmount;
  final String? paymentFrequency;
  final int? totalCycles;

  InvitationGroup({
    this.id,
    this.name,
    this.contributionAmount,
    this.targetPoolAmount,
    this.paymentFrequency,
    this.totalCycles,
  });

  factory InvitationGroup.fromJson(Map<String, dynamic> json) {
    return InvitationGroup(
      id: json['_id'],
      name: json['name'],
      contributionAmount: json['contributionAmount'],
      targetPoolAmount: json['targetPoolAmount'],
      paymentFrequency: json['paymentFrequency'],
      totalCycles: json['totalCycles'],
    );
  }
}

class InvitationSender {
  final String? id;
  final String? email;
  final String? image;
  final String? fullName;

  InvitationSender({
    this.id,
    this.email,
    this.image,
    this.fullName,
  });

  factory InvitationSender.fromJson(Map<String, dynamic> json) {
    return InvitationSender(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      image: json['image'],
      fullName: json['fullName'],
    );
  }
}
