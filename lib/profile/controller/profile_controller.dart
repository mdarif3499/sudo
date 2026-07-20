import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/log/app_utils.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/storage/storage_keys.dart';

class ProfileController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  final isNotificationOn = true.obs;
  final isLoading = false.obs;
  final profileData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.statusCode == 200) {
        profileData.value = response.data['data'];
        
        // Save userId to LocalStorage
        if (profileData.value != null && profileData.value!['_id'] != null) {
          await LocalStorage.setString(LocalStorageKeys.userId, profileData.value!['_id']);
          debugPrint("===> Saved UserId: ${profileData.value!['_id']}");
        }
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      debugPrint("===> Fetch Profile Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleNotification(bool value) {
    isNotificationOn.value = value;
  }

  Future<void> logOut() async {
    try {
      await LocalStorage.removeAllPrefData();
      Utils.successSnackBar("Logged out successfully");
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      debugPrint("===> Logout Error: $e");
      Utils.errorSnackBar("Logout Failed", e.toString());
    }
  }
}
