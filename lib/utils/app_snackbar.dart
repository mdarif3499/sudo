import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'constants/app_colors.dart';
import 'constants/app_string.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success({required String title, required String message}) {
    _showSnackbar(
      title: kDebugMode ? title : AppString.success.tr,
      message: message,
      backgroundColor: AppColors.black,
      position: SnackPosition.BOTTOM,
    );
  }

  static void error({String? title, required String message}) {
    _showSnackbar(
      title: kDebugMode ? (title ?? AppString.error.tr) : AppString.oops.tr,
      message: message,
      backgroundColor: AppColors.red,
      position: SnackPosition.TOP,
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required SnackPosition position,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: AppColors.white,
      backgroundColor: backgroundColor,
      snackPosition: position,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}
