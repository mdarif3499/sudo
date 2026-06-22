import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
              CommonText(
                text: "OTP Verification",
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              SizedBox(height: 12.h),
              CommonText(
                text:
                    "Enter the verification code we just sent to your email address.",
                fontSize: 14.sp,
                color: AppColors.textSecondaryColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              MaterialPinField(
                length: 6,
                onCompleted: (pin) {
                  controller.verifyOtp(pin);
                },
                onChanged: (value) {},
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: Size(50.w, 50.h),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              SizedBox(height: 32.h),
              CommonButton(
                titleText: "Verify",
                gradient: AppColors.primaryGradient,
                onTap: () {
                  Get.toNamed(AppRoutes.kyc);
                },
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: "Didn't receive code? ",
                    fontSize: 14.sp,
                    color: AppColors.textSecondaryColor,
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
                        fontSize: 14.sp,
                        color: controller.canResend.value
                            ? AppColors.color2F80ED
                            : AppColors.textSecondaryColor,
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
