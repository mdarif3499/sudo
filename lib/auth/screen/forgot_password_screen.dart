import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../utils/constants/app_colors.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CommonAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const CommonText(
                  text: "Forgot Password?",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: "Enter your email address and we'll send you a link to reset your password",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white70 : AppColors.textSecondaryColor.withValues(alpha: 0.8),
                ),
                SizedBox(height: 40.h),
                CommonTextField(
                  controller: controller.emailController,
                  title: "Email Address",
                  hintText: "john@example.com",
                  prefixIcon: Icon(
                    Icons.email_outlined, 
                    size: 20, 
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Email is required";
                    if (!GetUtils.isEmail(value)) return "Enter a valid email address";
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Obx(() => CommonButton(
                  isLoading: controller.isLoading.value,
                  titleText: "Send Otp",
                  gradient: AppColors.primaryGradient,
                  onTap: () => controller.sendOtp(),
                )),
                SizedBox(height: 24.h),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: CommonText(
                      text: "Back to Sign In",
                      fontSize: 16,
                      color: isDark ? Colors.white70 : AppColors.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
