import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api/api_service.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_utils.dart';
import '../../config/route/app_routes.dart';

class DashboardController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();

  var stripeConnected = true.obs;
  var detailsSubmitted = true.obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    checkStripeStatus();
  }

  Future<void> checkStripeStatus() async {
    try {
      final response = await _apiClient.post(ApiEndPoint.stripeAccountStatus);
      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        if (responseData != null) {
          stripeConnected.value = responseData['stripeConnected'] ?? false;
          detailsSubmitted.value = responseData['detailsSubmitted'] ?? false;

          debugPrint("Stripe Connection Status: ${stripeConnected.value}");

          if (!stripeConnected.value&&!detailsSubmitted.value) {
            showStripeConnectPopup();
          }
        }
      }
    } catch (e) {
      debugPrint("Error checking stripe status: $e");
    }
  }

  void showStripeConnectPopup() {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance_wallet_outlined, size: 48, color: Colors.blue),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Connect Your Stripe",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  "You must connect your Stripe account to receive payments. This is required for your account to remain active.",
                  style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Obx(() => ElevatedButton(
                  onPressed: isLoading.value ? null : () => connectStripe(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: isLoading.value 
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("Connect Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                )),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> connectStripe() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.post(ApiEndPoint.stripeConnectAccount);
      if (response.statusCode == 200 && response.data != null) {
        String? url = response.data['data']?['url'];
        if (url != null) {
          if (Get.isDialogOpen ?? false) Get.back();

          await Get.toNamed(AppRoutes.stripeWebView, arguments: url);
          checkStripeStatus();
        } else {
          Utils.errorSnackBar("Error", "Could not generate onboarding link.");
        }
      } else {
         Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
