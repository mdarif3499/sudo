import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../../../utils/constants/app_string.dart';
import '../data/payment_history_model.dart';

class PaymentHistoryController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  var historyList = <PaymentHistoryModel>[].obs;
  var isLoading = false.obs;
  
  // Stats
  var totalPaid = 0.0.obs;
  var thisMonthPaid = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory({String? groupId}) async {
    isLoading.value = true;
    try {
      String url = "${ApiEndPoint.contributionHistory}?type=all";
      if (groupId != null && groupId.isNotEmpty) {
        url += "&groupId=$groupId";
      }
      
      final response = await _apiClient.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        historyList.value = data.map((json) => PaymentHistoryModel.fromJson(json)).toList();
        _calculateStats();
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, "Failed to fetch payment history");
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateStats() {
    double total = 0.0;
    double month = 0.0;
    
    final now = DateTime.now();
    
    for (var item in historyList) {
      if (item.status?.toLowerCase() == 'paid') {
        final amount = (item.amount ?? 0).toDouble();
        total += amount;
        
        if (item.paymentDate != null) {
          final paymentDate = DateTime.parse(item.paymentDate!);
          if (paymentDate.month == now.month && paymentDate.year == now.year) {
            month += amount;
          }
        }
      }
    }
    
    totalPaid.value = total;
    thisMonthPaid.value = month;
  }
}
