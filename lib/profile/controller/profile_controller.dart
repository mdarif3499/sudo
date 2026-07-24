import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/log/app_utils.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/storage/storage_keys.dart';

import '../../home/data/dashboard_summary_model.dart';

class ProfileController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  final isNotificationOn = true.obs;
  final isLoading = false.obs;
  final profileData = Rxn<Map<String, dynamic>>();
  final dashboardData = Rxn<DashboardSummaryModel>();

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.wait([
      fetchProfile(),
      fetchDashboardSummary(),
    ]);
    isLoading.value = false;
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.statusCode == 200) {
        profileData.value = response.data['data'];
        
        if (profileData.value != null && profileData.value!['_id'] != null) {
          await LocalStorage.setString(LocalStorageKeys.userId, profileData.value!['_id']);
        }
      }
    } catch (e) {
      debugPrint("===> Fetch Profile Error: $e");
    }
  }

  Future<void> fetchDashboardSummary() async {
    try {
      final response = await _apiClient.get(ApiEndPoint.dashboardSummary);
      if (response.statusCode == 200) {
        dashboardData.value = DashboardSummaryModel.fromJson(response.data['data']);
      }
    } catch (e) {
      debugPrint("Error fetching dashboard summary: $e");
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
