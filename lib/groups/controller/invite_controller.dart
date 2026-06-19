import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PendingInvite {
  final String email;
  final String time;

  PendingInvite({required this.email, required this.time});
}

class InviteController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final String inviteLink = "https://savecircle.app/invite/abc123";
  
  var pendingInvites = <PendingInvite>[
    PendingInvite(email: "alice@example.com", time: "Sent 2 days ago"),
    PendingInvite(email: "bob@example.com", time: "Sent 5 days ago"),
  ].obs;

  void copyInviteLink() {
    Clipboard.setData(ClipboardData(text: inviteLink));
    Get.snackbar(
      "Success",
      "Invite link copied to clipboard",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void sendInvitation() {
    String email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Logic to send invitation would go here
    pendingInvites.insert(0, PendingInvite(email: email, time: "Sent just now"));
    emailController.clear();
    
    Get.snackbar(
      "Success",
      "Invitation sent to $email",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void resendInvitation(String email) {
    Get.snackbar(
      "Success",
      "Invitation resent to $email",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
