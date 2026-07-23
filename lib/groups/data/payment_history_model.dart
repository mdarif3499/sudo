class PaymentHistoryModel {
  final String? id;
  final PaymentHistoryGroup? group;
  final int? periodNumber;
  final PaymentHistoryUser? sender;
  final PaymentHistoryUser? receiver;
  final num? amount;
  final num? commissionAmount;
  final num? transferAmount;
  final String? stripeSessionId;
  final String? status;
  final String? paymentDate;
  final String? transactionId;
  final String? createdAt;

  PaymentHistoryModel({
    this.id,
    this.group,
    this.periodNumber,
    this.sender,
    this.receiver,
    this.amount,
    this.commissionAmount,
    this.transferAmount,
    this.stripeSessionId,
    this.status,
    this.paymentDate,
    this.transactionId,
    this.createdAt,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      id: json['_id'],
      group: json['groupId'] != null ? PaymentHistoryGroup.fromJson(json['groupId']) : null,
      periodNumber: json['periodNumber'],
      sender: json['senderId'] != null ? PaymentHistoryUser.fromJson(json['senderId']) : null,
      receiver: json['receiverId'] != null ? PaymentHistoryUser.fromJson(json['receiverId']) : null,
      amount: json['amount'],
      commissionAmount: json['commissionAmount'],
      transferAmount: json['transferAmount'],
      stripeSessionId: json['stripeSessionId'],
      status: json['status'],
      paymentDate: json['paymentDate'],
      transactionId: json['transactionId'],
      createdAt: json['createdAt'],
    );
  }
}

class PaymentHistoryGroup {
  final String? id;
  final String? name;
  final num? contributionAmount;
  final String? paymentFrequency;

  PaymentHistoryGroup({
    this.id,
    this.name,
    this.contributionAmount,
    this.paymentFrequency,
  });

  factory PaymentHistoryGroup.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryGroup(
      id: json['_id'],
      name: json['name'],
      contributionAmount: json['contributionAmount'],
      paymentFrequency: json['paymentFrequency'],
    );
  }
}

class PaymentHistoryUser {
  final String? id;
  final String? email;
  final String? fullName;

  PaymentHistoryUser({this.id, this.email, this.fullName});

  factory PaymentHistoryUser.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryUser(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }
}
