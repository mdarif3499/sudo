import 'package:flutter/material.dart';

class GroupModel {
  final String name;
  final int members;
  final double progress;
  final String percentage;
  final String poolTotal;
  final String myShare;
  final String nextDue;
  final String status;
  final Color progressColor;
  final List<MemberModel>? membersList;

  GroupModel({
    required this.name,
    required this.members,
    required this.progress,
    required this.percentage,
    required this.poolTotal,
    required this.myShare,
    required this.nextDue,
    required this.status,
    required this.progressColor,
    this.membersList,
  });
}

class MemberModel {
  final String name;
  final String amount;
  final String status;
  final bool isPaid;
  final String initials;
  final Color avatarColor;

  MemberModel({
    required this.name,
    required this.amount,
    required this.status,
    required this.isPaid,
    required this.initials,
    required this.avatarColor,
  });
}
