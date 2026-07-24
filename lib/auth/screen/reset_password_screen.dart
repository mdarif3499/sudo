import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../utils/constants/app_colors.dart';

import '../../../utils/constants/app_string.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: const CommonAppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: isDark ? null : const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFFFDF8),
              Color(0xFFF2FDFB),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.2, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CommonText(
                  text: AppString.resetPasswordTitle.tr,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: AppString.resetPasswordSubtitle.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white70 : AppColors.textSecondaryColor.withValues(alpha: 0.8),
                ),
                SizedBox(height: 40.h),
                CommonTextField(
                  controller: controller.newPasswordController,
                  title: AppString.newPassword.tr,
                  hintText: AppString.newPasswordHint.tr,
                  isPassword: true,
                  prefixIcon: Icon(
                    Icons.lock_outline, 
                    size: 20, 
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor
                  ),
                ),

                SizedBox(height: 20.h),

                CommonTextField(
                  controller: controller.confirmPasswordController,
                  title: AppString.confirmPassword.tr,
                  hintText: AppString.confirmPasswordHint.tr,
                  isPassword: true,
                  prefixIcon: Icon(
                    Icons.lock_outline, 
                    size: 20, 
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor
                  ),
                ),

                SizedBox(height: 40.h),

                CommonButton(
                  titleText: AppString.resetPassword.tr,
                  gradient: AppColors.primaryGradient,
                  onTap: () => controller.resetPassword(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
