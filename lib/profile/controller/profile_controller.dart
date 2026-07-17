import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/log/app_utils.dart';

class ProfileController extends GetxController {
  // নোটিফিকেশন স্টেট ফিরিয়ে আনা হলো
  final isNotificationOn = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // নোটিফিকেশন টগল মেথড ফিরিয়ে আনা হলো
  void toggleNotification(bool value) {
    isNotificationOn.value = value;
    // এখানে চাইলে ভবিষ্যতে এপিআই কল করে সার্ভারে সেভ করতে পারেন
  }

  /// প্রফেশনাল লগআউট মেথড
  Future<void> logOut() async {
    try {
      // ১. সব লোকাল ডাটা ক্লিয়ার করা (Token, UserInfo, etc.)
      await LocalStorage.removeAllPrefData();
      
      // ২. সাকসেস মেসেজ দেখানো
      Utils.successSnackBar("Logged out successfully");
      
      // ৩. লগইন স্ক্রিনে পাঠিয়ে দেয়া এবং ব্যাক স্ট্যাক ক্লিয়ার করা
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      debugPrint("===> Logout Error: $e");
      Utils.errorSnackBar("Logout Failed", e.toString());
    }
  }
}
