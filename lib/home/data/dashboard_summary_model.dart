class DashboardSummaryModel {
  final num? totalContribution;
  final num? totalSavings;
  final int? activeGroups;
  final num? thisMonthContribution;
  final List<ContributionModel>? last5Contributions;

  DashboardSummaryModel({
    this.totalContribution,
    this.totalSavings,
    this.activeGroups,
    this.thisMonthContribution,
    this.last5Contributions,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalContribution: json['totalContribution'],
      totalSavings: json['totalSavings'],
      activeGroups: json['activeGroups'],
      thisMonthContribution: json['thisMonthContribution'],
      last5Contributions: json['last5Contributions'] != null
          ? List<ContributionModel>.from(
              json['last5Contributions'].map((x) => ContributionModel.fromJson(x)))
          : [],
    );
  }
}

class ContributionModel {
  final String? id;
  final num? amount;
  final String? paymentDate;
  final String? transactionId;
  final int? periodNumber;
  final int? cycleNumber;
  final DashboardGroupModel? group;

  ContributionModel({
    this.id,
    this.amount,
    this.paymentDate,
    this.transactionId,
    this.periodNumber,
    this.cycleNumber,
    this.group,
  });

  factory ContributionModel.fromJson(Map<String, dynamic> json) {
    return ContributionModel(
      id: json['_id'],
      amount: json['amount'],
      paymentDate: json['paymentDate'],
      transactionId: json['transactionId'],
      periodNumber: json['periodNumber'],
      cycleNumber: json['cycleNumber'],
      group: json['group'] != null ? DashboardGroupModel.fromJson(json['group']) : null,
    );
  }
}

class DashboardGroupModel {
  final String? id;
  final String? name;
  final num? contributionAmount;
  final num? targetPoolAmount;
  final String? paymentFrequency;
  final int? totalCycles;

  DashboardGroupModel({
    this.id,
    this.name,
    this.contributionAmount,
    this.targetPoolAmount,
    this.paymentFrequency,
    this.totalCycles,
  });

  factory DashboardGroupModel.fromJson(Map<String, dynamic> json) {
    return DashboardGroupModel(
      id: json['_id'],
      name: json['name'],
      contributionAmount: json['contributionAmount'],
      targetPoolAmount: json['targetPoolAmount'],
      paymentFrequency: json['paymentFrequency'],
      totalCycles: json['totalCycles'],
    );
  }
}
