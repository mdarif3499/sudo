import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../controller/otp_controller.dart';
import '../../../component/text_field/common_pin_code_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              const CommonText(
                text: "OTP Verification",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 12.h),
              CommonText(
                text: "Enter the verification code we just sent to your email address.",
                fontSize: 14,
                color: isDark ? Colors.white70 : AppColors.textSecondaryColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              
              CommonPinCodeField(
                controller: controller.otpController,
                length: 6,
                onCompleted: (pin) {
                  controller.otpCode = pin;
                  controller.verifyOtp(pin);
                },
                onChanged: (value) {
                  controller.otpCode = value;
                },
              ),

              SizedBox(height: 32.h),
              Obx(() => CommonButton(
                isLoading: controller.isLoading.value,
                titleText: "Verify",
                gradient: AppColors.primaryGradient,
                onTap: () {
                  controller.verifyOtp(controller.otpCode);
                },
              )),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: "Didn't receive code? ",
                    fontSize: 14,
                    color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: controller.canResend.value
                          ? () => controller.resendOtp()
                          : null,
                      child: CommonText(
                        text: controller.canResend.value
                            ? "Resend"
                            : "Resend in ${controller.timerText.value}",
                        fontSize: 14,
                        color: controller.canResend.value
                            ? AppColors.color2F80ED
                            : (isDark ? Colors.white38 : AppColors.textSecondaryColor),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
