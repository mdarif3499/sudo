import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../data/group_details_model.dart';
import '../../services/storage/storage_services.dart';
import '../../component/bottom_nav_bar/bottom_nav_controller.dart';
import 'groups_controller.dart';

class GroupDetailsController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  var groupDetails = Rxn<GroupDetailsModel>();
  var isLoading = false.obs;
  var isStarting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String? groupId = Get.arguments;
    if (groupId != null) {
      fetchGroupDetails(groupId);
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

  Future<void> startGroup(String groupId) async {
    isStarting.value = true;
    try {
      final response = await _apiClient.post("${ApiEndPoint.startGroup}$groupId");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.successSnackBar("Group started successfully!");

        // 1. Refresh Groups List
        if (Get.isRegistered<GroupsController>()) {
          Get.find<GroupsController>().fetchMyGroups();
        }

        // 2. Navigate to Groups Tab (Index 1)
        if (Get.isRegistered<BottomNavController>()) {
          Get.find<BottomNavController>().selectedIndex.value = 1;
        }

        Get.back(); // Back to main screen
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
    
    // Backend theke admin object er moddhe thaka id check kora hocche
    final adminId = groupDetails.value!.group!.admin?.id ?? groupDetails.value!.group!.admin?.id;
    final currentUserId = LocalStorage.userId;

    return adminId == currentUserId;
  }
}
