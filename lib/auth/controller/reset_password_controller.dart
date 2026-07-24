import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  void resetPassword() {
    // Current implementation just navigates to success
    Get.toNamed(AppRoutes.success);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
