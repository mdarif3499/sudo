import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_keys.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/constants/app_string.dart';
import '../../../utils/log/app_utils.dart';
import '../../auth/screen/webview_screen.dart';

class SubscriptionController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  final isLoading = false.obs;

  Future<void> checkProfileAndKyc() async {
    String token = LocalStorage.token;
    if (token.isEmpty) return;

    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.isSuccess) {
        final data = response.data['data'];
        final kycStatus = data['kycStatus'] ?? ""; 

        // ১. এপিআই থেকে পাওয়া KYC স্ট্যাটাস স্টোরেজে সেভ করা হচ্ছে
        await LocalStorage.setString(LocalStorageKeys.kycStatus, kycStatus);

        if (kycStatus == 'approved') {
          // ২. যদি অ্যাপ্রুভড হয় তবে মেইন স্ক্রিনে যাবে
          Get.offAllNamed(AppRoutes.main);
        } else {
          // ৩. অন্যথায় কেওয়াইসি সেশন তৈরি করবে
          await createKycSession();
        }
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      debugPrint("===> checkProfileAndKyc Exception: $e");
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
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
          Get.to(() => WebviewScreen(checkoutUrl: kycUrl));
        }
      }
    } catch (e) {
      debugPrint("===> createKycSession Exception: $e");
    }
  }
}
