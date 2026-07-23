import 'package:get/get.dart';
import 'package:sudo/services/api/api_service.dart';
import '../../config/api/api_end_point.dart';
import '../data/faq_model.dart';
import 'package:flutter/material.dart';

class FaqController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  var expandedIndex = (-1).obs; 
  var isLoading = false.obs;
  var faqs = <FaqModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.faqAll);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        faqs.value = data.map((json) => FaqModel.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching FAQs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; 
    } else {
      expandedIndex.value = index; 
    }
  }
}
