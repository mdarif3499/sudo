import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/group_model.dart';

class GroupsController extends GetxController {
  var groupsList = <GroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadGroups();
  }

  void loadGroups() {
    groupsList.value = [
      GroupModel(
        name: "Family Savings",
        members: 4,
        progress: 0.75,
        percentage: "75%",
        poolTotal: "\$10,000",
        myShare: "\$1,250",
        nextDue: "Jun 15",
        status: "Active",
        progressColor: const Color(0xFF19CA77),
        membersList: [
          MemberModel(
            name: "John Doe",
            amount: "\$200",
            status: "Paid",
            isPaid: true,
            initials: "JD",
            avatarColor: const Color(0xFFE3F2FD),
          ),
          MemberModel(
            name: "Jane Smith",
            amount: "\$200",
            status: "Paid",
            isPaid: true,
            initials: "JS",
            avatarColor: const Color(0xFFE3F2FD),
          ),
          MemberModel(
            name: "Mike Johnson",
            amount: "\$200",
            status: "Pending",
            isPaid: false,
            initials: "MJ",
            avatarColor: const Color(0xFFE3F2FD),
          ),
          MemberModel(
            name: "Sarah Williams",
            amount: "\$200",
            status: "Paid",
            isPaid: true,
            initials: "SW",
            avatarColor: const Color(0xFFE3F2FD),
          ),
        ],
      ),
      GroupModel(
        name: "Friends Circle",
        members: 6,
        progress: 0.60,
        percentage: "60%",
        poolTotal: "\$10,000",
        myShare: "\$1,250",
        nextDue: "Jun 15",
        status: "Active",
        progressColor: const Color(0xFF48C8FC),
        membersList: [],
      ),
      GroupModel(
        name: "Wedding Fund",
        members: 12,
        progress: 1.0,
        percentage: "100%",
        poolTotal: "\$15,000",
        myShare: "\$1,500",
        nextDue: "Completed",
        status: "Active",
        progressColor: const Color(0xFF00CED1),
        membersList: [],
      ),
    ];
  }
}
