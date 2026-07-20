import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api/api_service.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_utils.dart';
import '../../config/route/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  Future<void> sendOtp() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiEndPoint.verifyAccount,
        body: {'email': emailController.text.trim()},
      );

      if (response.statusCode == 200) {
        Utils.successSnackBar(response.message);
        Get.toNamed(
          AppRoutes.forgotPasswordOtp,
          parameters: {
            'email': emailController.text.trim(),
            'isForgotPassword': 'true',
          },
        );
      } else {
        Utils.errorSnackBar("Failed", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
