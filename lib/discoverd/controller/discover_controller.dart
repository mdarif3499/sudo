import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupModel {
  final String title;
  final String members;
  final String frequency;
  final String target;
  final String perMember;
  final Color iconColor;
  final IconData icon;

  GroupModel({
    required this.title,
    required this.members,
    required this.frequency,
    required this.target,
    required this.perMember,
    required this.iconColor,
    required this.icon,
  });
}

class DiscoverController extends GetxController {
  var allGroups = <GroupModel>[].obs;
  var filteredGroups = <GroupModel>[].obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data matching the UI
    allGroups.value = [
      GroupModel(
        title: "Tech Professionals Savings",
        members: "24 members",
        frequency: "Monthly",
        target: "\$50,000",
        perMember: "\$500",
        iconColor: const Color(0xFFE8F1FF),
        icon: Icons.people_outline,
      ),
      GroupModel(
        title: "Young Entrepreneurs Fund",
        members: "18 members",
        frequency: "Monthly",
        target: "\$50,000",
        perMember: "\$500",
        iconColor: const Color(0xFFE8FFF4),
        icon: Icons.group_work_outlined,
      ),
      GroupModel(
        title: "Students Emergency Fund",
        members: "45 members",
        frequency: "Monthly",
        target: "\$50,000",
        perMember: "\$500",
        iconColor: const Color(0xFFFFF7E8),
        icon: Icons.school_outlined,
      ),
       GroupModel(
        title: "Young Entrepreneurs Fund",
        members: "18 members",
        frequency: "Monthly",
        target: "\$50,000",
        perMember: "\$500",
        iconColor: const Color(0xFFE8FFF4),
        icon: Icons.group_work_outlined,
      ),
      GroupModel(
        title: "Students Emergency Fund",
        members: "45 members",
        frequency: "Monthly",
        target: "\$50,000",
        perMember: "\$500",
        iconColor: const Color(0xFFFFF7E8),
        icon: Icons.school_outlined,
      ),
    ];
    filteredGroups.value = allGroups;
  }

  void filterGroups(String query) {
    if (query.isEmpty) {
      filteredGroups.value = allGroups;
    } else {
      filteredGroups.value = allGroups
          .where((group) =>
              group.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
