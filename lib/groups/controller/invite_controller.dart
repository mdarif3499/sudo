import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../../utils/constants/app_string.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';

class PendingInvite {
  final String email;
  final String time;

  PendingInvite({required this.email, required this.time});
}

class InviteController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  final TextEditingController emailController = TextEditingController();
  final String inviteLink = "https://savecircle.app/invite/abc123";
  
  var pendingInvites = <PendingInvite>[
    PendingInvite(email: "alice@example.com", time: "Sent 2 days ago"),
    PendingInvite(email: "bob@example.com", time: "Sent 5 days ago"),
  ].obs;

  var isLoading = false.obs;

  void copyInviteLink() {
    Clipboard.setData(ClipboardData(text: inviteLink));
    Utils.successSnackBar("Invite link copied to clipboard"); // Added key for this? No, but let's use someThingWrong for now or add it.
  }

  Future<void> sendInvitation(String groupId) async {
    String email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, AppString.enterValidEmail.tr);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiEndPoint.sendInvitation,
        body: {
          "groupId": groupId,
          "email": email,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emailController.clear();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Utils.successSnackBar(response.data['message'] ?? "Invitation sent successfully");
        pendingInvites.insert(0, PendingInvite(email: email, time: "Sent just now"));
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, "Failed to send invitation");
    } finally {
      isLoading.value = false;
    }
  }

  void resendInvitation(String email) {
    Utils.successSnackBar("Invitation resent to $email");
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
