import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_string.dart';
import '../../utils/log/app_utils.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void changePassword() {
    if (formKey.currentState!.validate()) {
      // Implement change password logic
      Get.back();
      Utils.successSnackBar(AppString.passwordChangedSuccess.tr);
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
