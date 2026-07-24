import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../../../utils/constants/app_string.dart';
import '../view/stripe_web_view_page.dart';

class MakePaymentController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  var selectedMethod = "Stripe".obs;
  var isLoading = false.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }
  
  Future<void> makePayment({
    required String groupId,
    required int periodNumber,
  }) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        "${ApiEndPoint.payGroup}$groupId",
        body: {
          "periodNumber": periodNumber,
        },
      );

      if (response.statusCode == 200) {
        final url = response.data['data']['url'];
        if (url != null) {
          Get.to(() => StripeWebViewPage(checkoutUrl: url));
        } else {
          Utils.errorSnackBar(AppString.someThingWrong.tr, "Checkout URL not found");
        }
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, "Failed to initiate payment: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
