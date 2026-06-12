import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                text: "Reset Password",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Create a new password for your account",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryColor.withValues(alpha: 0.8),
              ),
              SizedBox(height: 40.h),
              CommonTextField(
                title: "New Password",
                hintText: "Min. 8 characters",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondaryColor),
              ),

              SizedBox(height: 20.h),

              CommonTextField(
                title: "Confirm Password",
                hintText: "Re-enter your password",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondaryColor),
              ),

              SizedBox(height: 40.h),

              CommonButton(
                titleText: "Reset Password",
                gradient: AppColors.primaryGradient,
                onTap: () => Get.toNamed(AppRoutes.success),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
