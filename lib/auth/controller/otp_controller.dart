import 'dart:async';
import 'package:get/get.dart';
import '../../../config/route/app_routes.dart';

class OtpController extends GetxController {
  var timerText = '02:00'.obs;
  var canResend = false.obs;
  Timer? _timer;
  int _start = 120;

  @override
  void onInit() {
    super.onInit();
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

  void resendOtp() {
    if (canResend.value) {
      startTimer();
      // Add logic to resend OTP via API
    }
  }

  void verifyOtp(String code) {
    if (code.length == 6) {
      // Add logic to verify OTP via API
      Get.toNamed(AppRoutes.kyc);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
