import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../config/route/app_routes.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
                const CommonText(
                  text: "Welcome Back",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: "Sign in to continue saving",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white70 : AppColors.textSecondaryColor7C7C7C,
                ),
                SizedBox(height: 36.h),
                CommonTextField(
                  controller: controller.emailController,
                  title: "Email Address",
                  hintText: "john@example.com",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  controller: controller.passwordController,
                  title: "Password",
                  hintText: "Min. 8 characters",
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: isDark ? Colors.white54 : AppColors.textSecondaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
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
                    child: const CommonText(
                      text: "Forgot Password?",
                      fontSize: 14,
                      color: AppColors.buttonGradientEnd,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                Obx(() => CommonButton(
                  isLoading: controller.isLoading.value,
                  titleText: "Sign In",
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
                      text: "Don’t have an account? ",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.register),
                      child: const CommonText(
                        text: "Sign Up",
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
    );
  }
}
