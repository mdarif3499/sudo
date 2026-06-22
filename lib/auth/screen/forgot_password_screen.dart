import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../config/route/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CommonText(
                text: "Forgot Password?",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Enter you email address and we'll send you a link to reset your password",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryColor.withValues(alpha: 0.8),
              ),
              SizedBox(height: 40.h),
              CommonTextField(
                title: "Email Address",
                hintText: "john@example.com",
                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColors.textSecondaryColor),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 40.h),
              CommonButton(
                titleText: "Send Reset Link",
                gradient: AppColors.primaryGradient,
                onTap: () => Get.toNamed(AppRoutes.resetPassword),
              ),
              SizedBox(height: 24.h),
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: CommonText(
                    text: "Back to Sign In",
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
