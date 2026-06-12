import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              CommonText(
                text: "Welcome Back",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Sign in to continue saving",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryColor7C7C7C,
              ),
              SizedBox(height: 36.h),
              CommonTextField(
                title: "Email Address",
                hintText: "john@example.com",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              CommonTextField(
                title: "Password",
                hintText: "Min. 8 characters",
                isPassword: true,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
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
                    text: "Forgot Password?",
                    fontSize: 14,
                    color: AppColors.buttonGradientEnd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CommonButton(
                titleText: "Sign In",
                gradient: AppColors.primaryGradient,
                onTap: () {
                  Get.offAllNamed(AppRoutes.main);
                },
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: "Don’t have an account? ",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondaryColor,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.register),
                    child: CommonText(
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
    );
  }
}
