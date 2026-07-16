import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_keys.dart';
import '../../../services/storage/storage_services.dart';
import '../../auth/screen/webview_screen.dart';

class SubscriptionController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  final isLoading = false.obs;

  Future<void> checkProfileAndKyc() async {
    String token = await LocalStorage.getString(LocalStorageKeys.token);
    if (token.isEmpty) return;

    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.isSuccess) {
        final data = response.data['data'];
        final kycStatus = data['kycStatus']; 

        if (kycStatus != 'approved') {
          await createKycSession();
        } else {
          Get.toNamed(AppRoutes.main);
        }
      }
    } catch (e) {
      debugPrint("===> checkProfileAndKyc Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createKycSession() async {
    try {
      final response = await _apiClient.post(ApiEndPoint.createKycSession);
      if (response.isSuccess) {
        final kycUrl = response.data['data']['url'];
        if (kycUrl != null && kycUrl.isNotEmpty) {
          Get.to(() => StripeWebViewPage(checkoutUrl: kycUrl));
        }
      }
    } catch (e) {
      debugPrint("===> createKycSession Exception: $e");
    }
  }
}
