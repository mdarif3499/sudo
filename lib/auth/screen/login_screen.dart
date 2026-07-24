import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_string.dart';
import '../../services/theme/theme_controller.dart';
import '../controller/sign_in_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Professional Theme Toggle Icon
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Obx(() => IconButton(
                        onPressed: () => themeController.toggleTheme(),
                        icon: Icon(
                          themeController.isDarkMode.value
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round,
                          size: 28.sp,
                          color: themeController.isDarkMode.value 
                              ? Colors.orangeAccent 
                              : AppColors.textPrimaryColor,
                        ),
                      )),
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                  CommonText(
                    text: AppString.welcomeBack.tr,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    text: AppString.signInSubtitle.tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : AppColors.textSecondaryColor7C7C7C,
                  ),
                  SizedBox(height: 36.h),
                  CommonTextField(
                    controller: controller.emailController,
                    title: AppString.emailAddress.tr,
                    hintText: AppString.emailHint.tr,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.emailRequired.tr;
                      }
                      if (!GetUtils.isEmail(value)) {
                        return AppString.enterValidEmail.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  CommonTextField(
                    controller: controller.passwordController,
                    title: AppString.password.tr,
                    hintText: AppString.passwordHint.tr,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.thisFieldIsRequired.tr;
                      }
                      if (value.length < 6) {
                        return AppString.enterValidPassword.tr;
                      }
                      return null;
                    },
                    onSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        controller.signIn();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: CommonText(
                        text: AppString.forgotPassword.tr,
                        fontSize: 14,
                        color: AppColors.buttonGradientEnd,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Obx(() => CommonButton(
                    isLoading: controller.isLoading.value,
                    titleText: AppString.signIn.tr,
                    gradient: AppColors.primaryGradient,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signIn();
                      }
                    },
                  )),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: AppString.dontHaveAccount.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: CommonText(
                          text: AppString.signUp.tr,
                          fontSize: 14,
                          color: AppColors.buttonGradientEnd,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
