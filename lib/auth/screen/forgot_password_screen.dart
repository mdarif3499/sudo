import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_string.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
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
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CommonText(
                    text: AppString.forgotPasswordTitle.tr,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    text: AppString.forgotPasswordSubtitle.tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : AppColors.textSecondaryColor.withValues(alpha: 0.8),
                  ),
                  SizedBox(height: 40.h),
                  CommonTextField(
                    controller: controller.emailController,
                    title: AppString.emailAddress.tr,
                    hintText: AppString.emailHint.tr,
                    prefixIcon: Icon(
                      Icons.email_outlined, 
                      size: 20, 
                      color: isDark ? Colors.white54 : AppColors.textSecondaryColor
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return AppString.emailRequired.tr;
                      if (!GetUtils.isEmail(value)) return AppString.enterValidEmail.tr;
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  Obx(() => CommonButton(
                    isLoading: controller.isLoading.value,
                    titleText: AppString.sendOtp.tr,
                    gradient: AppColors.primaryGradient,
                    onTap: () => controller.sendOtp(),
                  )),
                  SizedBox(height: 24.h),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: CommonText(
                        text: AppString.backToSignIn.tr,
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
      ),
    );
  }
}
