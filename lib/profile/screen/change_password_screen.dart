import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(title: AppString.changePassword.tr),
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
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  
                  // Old Password Field
                  CommonTextField(
                    controller: controller.oldPasswordController,
                    title: AppString.oldPassword.tr,
                    hintText: AppString.passwordHint.tr,
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 20, color: isDark ? Colors.white54 : const Color(0xFF94A3B8)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.oldPasswordRequired.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  
                  // New Password Field
                  CommonTextField(
                    controller: controller.newPasswordController,
                    title: AppString.newPasswordLabel.tr,
                    hintText: AppString.passwordHint.tr,
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 20, color: isDark ? Colors.white54 : const Color(0xFF94A3B8)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.thisFieldIsRequired.tr;
                      }
                      if (value.length < 8) {
                        return AppString.passwordMustBeeEightCharacters.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  
                  // Confirm Password Field
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    title: AppString.confirmNewPassword.tr,
                    hintText: AppString.passwordHint.tr,
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 20, color: isDark ? Colors.white54 : const Color(0xFF94A3B8)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.thisFieldIsRequired.tr;
                      }
                      if (value != controller.newPasswordController.text) {
                        return AppString.passwordsDoNotMatch.tr;
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(height: 40.h),
                  
                  // Save Changes Button (Stripe Blue Gradient)
                  CommonButton(
                    titleText: AppString.saveChanges.tr,
                    gradient: AppColors.primaryGradient,
                    onTap: () => controller.changePassword(),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
