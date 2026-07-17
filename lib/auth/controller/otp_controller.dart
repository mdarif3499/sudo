import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../../../utils/log/app_utils.dart';
import '../../../services/storage/storage_keys.dart';
import '../../../services/storage/storage_services.dart';
import '../screen/webview_screen.dart';

class OtpController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  final otpController = TextEditingController();
  final timerText = '02:00'.obs;
  final canResend = false.obs;
  final isLoading = false.obs;
  
  Timer? _timer;
  int _start = 120;
  
  String email = "";
  bool isForgotPassword = false;
  String otpCode = "";

  @override
  void onInit() {
    super.onInit();
    email = Get.parameters['email'] ?? "";
    isForgotPassword = Get.parameters['isForgotPassword'] == 'true';
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    _start = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        _start--;
        int minutes = _start ~/ 60;
        int seconds = _start % 60;
        timerText.value =
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiEndPoint.resendOtp,
        body: {
          'email': email,
          'authType': isForgotPassword ? 'forgetPassword' : 'createAccount',
        },
      );

      if (response.isSuccess) {
        Utils.successSnackBar(response.message);
        startTimer();
      } else {
        Utils.errorSnackBar("Error", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String code) async {
    if (code.length != 6) {
      Utils.errorSnackBar("Validation Error", "Please enter 6 digit OTP");
      return;
    }

    isLoading.value = true;
    try {
      final endpoint = isForgotPassword ? ApiEndPoint.verifyOtp : ApiEndPoint.verifyAccount;
      
      final response = await _apiClient.post(
        endpoint,
        body: {
          'email': email,
          'oneTimeCode': code,
        },
      );

      if (response.isSuccess) {
        if (isForgotPassword) {
          Utils.successSnackBar(response.message);
          Get.toNamed(AppRoutes.resetPassword, parameters: {
            'email': email,
            'otp': code,
          });
        } else {
          // Registration flow: Save tokens
          final data = response.data['data'];
          if (data != null) {
            // Save Tokens
            await LocalStorage.setString(LocalStorageKeys.token, data['accessToken'] ?? "");
            await LocalStorage.setString(LocalStorageKeys.refreshToken, data['refreshToken'] ?? "");
            await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
            
            // Save User Info
            final userInfo = data['userInfo'];
            if (userInfo != null) {
              await LocalStorage.setString(LocalStorageKeys.userId, userInfo['id'] ?? "");
              await LocalStorage.setString(LocalStorageKeys.role, userInfo['role'] ?? "");
              await LocalStorage.setString(LocalStorageKeys.myName, userInfo['name'] ?? "");
              await LocalStorage.setString(LocalStorageKeys.myEmail, userInfo['email'] ?? "");
              await LocalStorage.setString(LocalStorageKeys.myImage, userInfo['image'] ?? "");
            }
            
            Utils.successSnackBar(response.message);

            // Check Profile and KYC Status
            await checkProfileAndKyc();
          } else {
             Utils.errorSnackBar("Error", "Invalid response from server");
          }
        }
      } else {
        Utils.errorSnackBar("Verification Failed", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkProfileAndKyc() async {
    String token = await LocalStorage.getString(LocalStorageKeys.token);
    if (token.isEmpty) {
      debugPrint("===> No token found.");
      return;
    }

    try {
      debugPrint("===> Calling Profile API: ${ApiEndPoint.getProfile}");
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      
      if (response.isSuccess) {
        final data = response.data['data'];
        final kycStatus = data['kycStatus']; // 'unverified' | 'pending' | 'approved' | 'rejected'
        debugPrint("===> KYC Status: $kycStatus");

        if (kycStatus != 'approved') {
          await createKycSession();
        } else {
          Get.offAllNamed(AppRoutes.subscriptionScreen);
        }
      } else {
        debugPrint("===> Profile API Error: ${response.message}");
      }
    } catch (e) {
      debugPrint("===> checkProfileAndKyc Exception: $e");
    }
  }

  Future<void> createKycSession() async {
    try {
      debugPrint("===> Creating KYC Session...");
      final response = await _apiClient.post(ApiEndPoint.createKycSession);
      
      if (response.isSuccess) {
        final kycUrl = response.data['data']['url'];
        if (kycUrl != null && kycUrl.isNotEmpty) {
           Get.offAll(() => WebviewScreen(checkoutUrl: kycUrl));
        } else {
          Utils.errorSnackBar("KYC Error", "Could not initialize KYC session");
        }
      } else {
        debugPrint("===> KYC Session API Failed: ${response.message}");
      }
    } catch (e) {
      debugPrint("===> createKycSession Exception: $e");
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
