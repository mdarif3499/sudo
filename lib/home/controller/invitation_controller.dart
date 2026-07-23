import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../data/group_invitation_model.dart';
import '../../groups/controller/groups_controller.dart';

class InvitationController extends GetxController {
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  var invitations = <GroupInvitationModel>[].obs;
  var isLoading = false.obs;
  var isActionLoading = false.obs;

  List<GroupInvitationModel> get pendingInvitations => 
      invitations.where((invite) => invite.status == 'pending').toList();

  @override
  void onInit() {
    super.onInit();
    fetchInvitations();
  }

  Future<void> fetchInvitations() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.myInvitations);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        invitations.value = data.map((json) => GroupInvitationModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching invitations: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> respondToInvitation(String invitationId, bool accept) async {
    isActionLoading.value = true;
    try {
      final response = await _apiClient.post(
        "${ApiEndPoint.respondInvitation}$invitationId",
        body: {
          "action": accept ? "accept" : "decline"
        },
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.successSnackBar(response.data['message'] ?? (accept ? "Joined group successfully" : "Invitation declined"));
        
        // Refresh invitations
        fetchInvitations();
        
        // If accepted, refresh my groups
        if (accept && Get.isRegistered<GroupsController>()) {
          Get.find<GroupsController>().fetchMyGroups();
        }
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Failed to process invitation");
    } finally {
      isActionLoading.value = false;
    }
  }
}
