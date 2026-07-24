import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/terms_condition_model.dart';

class TermsConditionController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  var isLoading = false.obs;
  var termsCondition = Rxn<TermsConditionModel>();

  @override
  void onInit() {
    super.onInit();
    fetchTermsCondition();
  }

  Future<void> fetchTermsCondition() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.termsAndCondition);
      if (response.statusCode == 200) {
        termsCondition.value = TermsConditionModel.fromJson(response.data['data']);
      }
    } catch (e) {
      debugPrint("Error fetching terms and conditions: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
