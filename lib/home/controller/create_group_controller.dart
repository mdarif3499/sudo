import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudo/config/route/app_routes.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../../utils/constants/app_string.dart';
import 'package:intl/intl.dart';
import '../../component/bottom_nav_bar/bottom_nav_controller.dart';
import '../../groups/controller/groups_controller.dart';

class CreateGroupController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();

  final nameController = TextEditingController();
  final targetAmountController = TextEditingController();
  final contributionController = TextEditingController();
  final totalCyclesController = TextEditingController();
  final startDateController = TextEditingController();

  final selectedFrequency = "Weekly".obs;
  final selectedVisibility = "Private".obs;
  final selectedDuration = "2 Weeks".obs;
  final isLoading = false.obs;

  String? contributionError;
  String? targetError;

  DateTime? selectedDate;

  void setFrequency(String value) {
    selectedFrequency.value = value;
    if (value == "Weekly") {
      selectedDuration.value = "2 Weeks";
    } else if (value == "Monthly") {
      selectedDuration.value = "1 Month";
    } else if (value == "Quarterly") {
      selectedDuration.value = "3 Months";
    }
  }

  void setVisibility(String value) {
    selectedVisibility.value = value;
  }

  void setDuration(String value) {
    selectedDuration.value = value;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      startDateController.text = DateFormat('MM/dd/yyyy').format(selectedDate!);
    }
  }

  void validateAmounts() {
    double target = double.tryParse(targetAmountController.text) ?? 0;
    double contribution = double.tryParse(contributionController.text) ?? 0;

    if (target > 0 && contribution > 0) {
      if (target % contribution != 0) {
        contributionError = "${AppString.target.tr} ($target) must be divisible by ${AppString.contribution.tr.toLowerCase()} ($contribution)";
      } else {
        contributionError = null;
        // Logic removed so user can enter total cycles manually
      }
    } else {
      contributionError = null;
    }
    update();
  }

  int get targetedMembers {
    double target = double.tryParse(targetAmountController.text) ?? 0;
    double contribution = double.tryParse(contributionController.text) ?? 1;
    if (contribution <= 0) return 0;
    return (target / contribution).ceil();
  }

  Future<void> createGroup() async {
    if (nameController.text.isEmpty ||
        targetAmountController.text.isEmpty ||
        contributionController.text.isEmpty ||
        totalCyclesController.text.isEmpty ||
        selectedDate == null) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, AppString.fillAllFields.tr);
      return;
    }

    int target = int.tryParse(targetAmountController.text) ?? 0;
    int contribution = int.tryParse(contributionController.text) ?? 0;
    int totalCycles = int.tryParse(totalCyclesController.text) ?? 0;

    if (contribution == 0 || target % contribution != 0) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, AppString.poolAmountDivisibleError.tr);
      return;
    }

    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {
        "name": nameController.text,
        "contributionAmount": contribution,
        "targetPoolAmount": target,
        "paymentFrequency": selectedFrequency.value.toLowerCase(),
        "totalCycles": totalCycles,
        "startDate": selectedDate!.toIso8601String(),
        "visibility": selectedVisibility.value.toLowerCase(),
        if (selectedFrequency.value == "Quarterly")
          "quarterlyIntervalMonths": int.tryParse(selectedDuration.value.split(' ')[0]) ?? 3,
      };

      final response = await _apiClient.post(
        ApiEndPoint.createGroup,
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Utils.successSnackBar(AppString.groupCreatedSuccess.tr);
        
        if (Get.isRegistered<GroupsController>()) {
          Get.find<GroupsController>().fetchMyGroups();
        } else {
          Get.put(GroupsController()).fetchMyGroups();
        }
        
        if (Get.isRegistered<BottomNavController>()) {
          Get.find<BottomNavController>().selectedIndex.value = 1;
        }

        Get.toNamed(AppRoutes.main);
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    targetAmountController.dispose();
    contributionController.dispose();
    totalCyclesController.dispose();
    startDateController.dispose();
    super.onClose();
  }
}
