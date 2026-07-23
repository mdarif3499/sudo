import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../data/group_details_model.dart';
import '../../services/storage/storage_services.dart';
import '../../component/bottom_nav_bar/bottom_nav_controller.dart';
import '../data/period_history_model.dart';
import 'groups_controller.dart';

class GroupDetailsController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  var groupDetails = Rxn<GroupDetailsModel>();
  var periodHistory = Rxn<PeriodHistoryModel>();
  var isLoading = false.obs;
  var isHistoryLoading = false.obs;
  var isStarting = false.obs;
  String? _groupId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    
    if (args is String) {
      _groupId = args;
    } else if (args is Map<String, dynamic>) {
      _groupId = args['id'];
    }

    if (_groupId != null) {
      fetchGroupDetails(_groupId!);
      fetchPeriodHistory(_groupId!);
    }
  }

  Future<void> fetchGroupDetails(String groupId) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get("${ApiEndPoint.baseUrl}/group/$groupId");
      
      if (response.statusCode == 200) {
        groupDetails.value = GroupDetailsModel.fromJson(response.data['data']);
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPeriodHistory(String groupId, {int? periodNumber}) async {
    isHistoryLoading.value = true;
    try {
      String url = "${ApiEndPoint.groupPeriodHistory}$groupId";
      if (periodNumber != null) {
        url += "?periodNumber=$periodNumber";
      }
      
      final response = await _apiClient.get(url);
      
      if (response.statusCode == 200) {
        periodHistory.value = PeriodHistoryModel.fromJson(response.data['data']);
      } else {
        // Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      // Utils.errorSnackBar("Error", e.toString());
    } finally {
      isHistoryLoading.value = false;
    }
  }

  void loadNextPeriod() {
    if (periodHistory.value != null && periodHistory.value!.periodNumber != null) {
      if (_groupId != null) {
        fetchPeriodHistory(_groupId!, periodNumber: periodHistory.value!.periodNumber! + 1);
      }
    }
  }
  
  void loadPreviousPeriod() {
    if (periodHistory.value != null && periodHistory.value!.periodNumber != null && periodHistory.value!.periodNumber! > 1) {
      if (_groupId != null) {
        fetchPeriodHistory(_groupId!, periodNumber: periodHistory.value!.periodNumber! - 1);
      }
    }
  }

  Future<void> startGroup(String groupId) async {
    isStarting.value = true;
    try {
      final response = await _apiClient.post("${ApiEndPoint.startGroup}$groupId");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.successSnackBar("Group started successfully!");

        if (Get.isRegistered<GroupsController>()) {
          Get.find<GroupsController>().fetchMyGroups();
        }

        if (Get.isRegistered<BottomNavController>()) {
          Get.find<BottomNavController>().selectedIndex.value = 1;
        }

        Get.back();
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Failed to start group");
    } finally {
      isStarting.value = false;
    }
  }

  bool isUserAdmin() {
    if (groupDetails.value == null || groupDetails.value!.group == null) return false;
    final adminId = groupDetails.value!.group!.admin?.id;
    final currentUserId = LocalStorage.userId;
    return adminId == currentUserId;
  }
  
  bool isCurrentUserReceiver() {
    if (periodHistory.value == null) return false;
    final currentUserId = LocalStorage.userId;
    final member = periodHistory.value!.members?.firstWhereOrNull((m) => m.member?.id == currentUserId);
    return member?.status?.toLowerCase() == "receiver";
  }

  bool isCurrentUserPending() {
    if (periodHistory.value == null) return false;
    final currentUserId = LocalStorage.userId;
    final member = periodHistory.value!.members?.firstWhereOrNull((m) => m.member?.id == currentUserId);
    return member?.status?.toLowerCase() == "pending";
  }

  bool isCurrentUserPaid() {
    if (periodHistory.value == null) return false;
    final currentUserId = LocalStorage.userId;
    final member = periodHistory.value!.members?.firstWhereOrNull((m) => m.member?.id == currentUserId);
    return member?.status?.toLowerCase() == "paid";
  }
}
