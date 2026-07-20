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
  final DioApiClient _apiClient = Get.find<DioApiClient>();
  
  final otpController = TextEditingController();
  final timerText = '02:00'.obs;
  final canResend = false.obs;
  final isLoading = false.obs;
  
  // ওটিপি কোড হোল্ড করার জন্য ভেরিয়েবল
  final _otpCode = "".obs;
  String get otpCode => _otpCode.value;
  set otpCode(String value) => _otpCode.value = value;
  
  Timer? _timer;
  int _start = 120;
  
  String email = "";
  bool isForgotPassword = false;

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

      if (response.statusCode == 200) {
        Utils.successSnackBar(response.message);
        startTimer();
      } else {
        Utils.errorSnackBar("Resend Failed", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String code) async {
    if (code.length != 6) {
      Utils.errorSnackBar("Error", "Please enter 6 digit code");
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

      if (response.statusCode == 200) {
        if (isForgotPassword) {
          Utils.successSnackBar("OTP Verified");
          Get.toNamed(AppRoutes.resetPassword, parameters: {
            'email': email,
            'otp': code,
          });
        } else {
          var responseData = response.data['data'];
          if (responseData != null) {
            await _saveUserData(responseData);
            Utils.successSnackBar(response.message);
            await checkProfileAndKyc();
          }
        }
      } else {
        Utils.errorSnackBar("Failed", response.message);
      }
    } catch (e) {
      Utils.errorSnackBar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveUserData(dynamic data) async {
    await LocalStorage.setString(LocalStorageKeys.token, data['accessToken'] ?? "");
    await LocalStorage.setString(LocalStorageKeys.refreshToken, data['refreshToken'] ?? "");
    await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
    
    final userInfo = data['userInfo'];
    if (userInfo != null) {
      await LocalStorage.setString(LocalStorageKeys.userId, userInfo['id'] ?? "");
      await LocalStorage.setString(LocalStorageKeys.role, userInfo['role'] ?? "");
      await LocalStorage.setString(LocalStorageKeys.myName, userInfo['name'] ?? "");
      await LocalStorage.setString(LocalStorageKeys.myEmail, userInfo['email'] ?? "");
      await LocalStorage.setString(LocalStorageKeys.myImage, userInfo['image'] ?? "");
    }
  }

  Future<void> checkProfileAndKyc() async {
    try {
      final response = await _apiClient.get(ApiEndPoint.getProfile);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final kycStatus = data['kycStatus']; 

        if (kycStatus != 'approved') {
          await createKycSession();
        } else {
          Get.offAllNamed(AppRoutes.subscriptionScreen);
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> createKycSession() async {
    try {
      final response = await _apiClient.post(ApiEndPoint.createKycSession);
      if (response.statusCode == 200) {
        final kycUrl = response.data['data']?['url'];
        if (kycUrl != null) {
           Get.offAll(() => WebviewScreen(checkoutUrl: kycUrl));
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
