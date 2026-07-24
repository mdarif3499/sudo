import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/privacy_policy_model.dart';

class PrivacyPolicyController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  var isLoading = false.obs;
  var privacyPolicy = Rxn<PrivacyPolicyModel>();

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.privacyPolicy);
      if (response.statusCode == 200) {
        privacyPolicy.value = PrivacyPolicyModel.fromJson(response.data['data']);
      }
    } catch (e) {
      debugPrint("Error fetching privacy policy: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
