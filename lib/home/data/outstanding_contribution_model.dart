class OutstandingContributionResponse {
  final List<OutstandingContributionItem>? currentDues;
  final List<OutstandingContributionItem>? overdues;

  OutstandingContributionResponse({this.currentDues, this.overdues});

  factory OutstandingContributionResponse.fromJson(Map<String, dynamic> json) {
    return OutstandingContributionResponse(
      currentDues: json['currentDues'] != null
          ? List<OutstandingContributionItem>.from(
              json['currentDues'].map((x) => OutstandingContributionItem.fromJson(x)))
          : [],
      overdues: json['overdues'] != null
          ? List<OutstandingContributionItem>.from(
              json['overdues'].map((x) => OutstandingContributionItem.fromJson(x)))
          : [],
    );
  }
}

class OutstandingContributionItem {
  final String? groupId;
  final String? groupName;
  final int? periodNumber;
  final int? cycleNumber;
  final num? amount;
  final String? dueDate;

  OutstandingContributionItem({
    this.groupId,
    this.groupName,
    this.periodNumber,
    this.cycleNumber,
    this.amount,
    this.dueDate,
  });

  factory OutstandingContributionItem.fromJson(Map<String, dynamic> json) {
    return OutstandingContributionItem(
      groupId: json['groupId'],
      groupName: json['groupName'],
      periodNumber: json['periodNumber'],
      cycleNumber: json['cycleNumber'],
      amount: json['amount'],
      dueDate: json['dueDate'],
    );
  }
}
