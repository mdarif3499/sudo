import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_keys.dart';
import '../../../services/storage/storage_services.dart';
import '../../../services/socket/socket_service.dart';
import '../../../utils/log/app_utils.dart';
import '../screen/webview_screen.dart';

class SignInController extends GetxController {
  final ApiClient _apiClient = DioApiClient();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Utils.errorSnackBar("Error", "Please fill all fields");
      return;
    }

    isLoading.value = true;
    try {
      String deviceToken = await LocalStorage.getString(LocalStorageKeys.fcmToken);
      
      final response = await _apiClient.post(
        ApiEndPoint.signIn,
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'deviceToken': deviceToken.isEmpty ? "no_token" : deviceToken,
        },
      );

      if (response.isSuccess) {
        final data = response.data['data'];
        if (data != null) {
          await LocalStorage.setString(LocalStorageKeys.token, data['accessToken'] ?? "");
          await LocalStorage.setString(LocalStorageKeys.refreshToken, data['refreshToken'] ?? "");
          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          SocketService.connect(forceNew: true);

          final userInfo = data['userInfo'];
          if (userInfo != null) {
            await LocalStorage.setString(LocalStorageKeys.userId, userInfo['id'] ?? "");
            await LocalStorage.setString(LocalStorageKeys.role, userInfo['role'] ?? "");
            await LocalStorage.setString(LocalStorageKeys.myName, userInfo['name'] ?? "");
            await LocalStorage.setString(LocalStorageKeys.myEmail, userInfo['email'] ?? "");
            await LocalStorage.setString(LocalStorageKeys.myImage, userInfo['image'] ?? "");
          }

          await checkProfileAndKyc();
          Utils.successSnackBar(response.message);
        }
      } else if (response.statusCode == 407) {
        Get.toNamed(AppRoutes.otp, parameters: {'email': emailController.text.trim()});
      } else {
        Utils.errorSnackBar("Login Failed", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkProfileAndKyc() async {
    String token = LocalStorage.token;
    if (token.isEmpty) return;

    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.isSuccess) {
        final data = response.data['data'];
        final kycStatus = data['kycStatus'] ?? ""; 

        // কেওয়াইসি স্ট্যাটাস স্টোরেজে সেভ করা হচ্ছে
        await LocalStorage.setString(LocalStorageKeys.kycStatus, kycStatus);

        if (kycStatus == 'approved') {
          // যদি অ্যাপ্রুভড হয় তবে মেইন স্ক্রিনে যাবে
          Get.offAllNamed(AppRoutes.main);
        } else if (kycStatus == 'pending') {
          // পেন্ডিং থাকলে সাবস্ক্রিপশন বা ওয়েটিং স্ক্রিন
          Get.offAllNamed(AppRoutes.subscriptionScreen);
        } else {
          // অন্যথায় কেওয়াইসি সেশন তৈরি করবে
          await createKycSession();
        }
      }
    } catch (e) {
      debugPrint("===> checkProfileAndKyc Exception: $e");
    }
  }

  Future<void> createKycSession() async {
    try {
      final response = await _apiClient.post(ApiEndPoint.createKycSession);
      if (response.isSuccess) {
        final kycUrl = response.data['data']['url'];
        if (kycUrl != null && kycUrl.isNotEmpty) {
          Get.offAll(() => WebviewScreen(checkoutUrl: kycUrl));
        }
      }
    } catch (e) {
      debugPrint("===> createKycSession Exception: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
