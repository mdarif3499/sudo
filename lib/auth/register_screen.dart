import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              SizedBox(height: 40.h),
              CommonText(
                text: "Create Account",
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryColor,
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: "Join thousands saving together",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryColor,
              ),
              SizedBox(height: 32.h),
              CommonTextField(
                title: "Full Name",
                hintText: "John Doe",
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: 20.h),
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
                title: "Phone Number",
                hintText: "+1 (555) 000-0000",
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.h),
              CommonTextField(
                title: "Address",
                hintText: "+1 (555) 000-0000",
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
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
              SizedBox(height: 20.h),
              CommonTextField(
                title: "Confirm Password",
                hintText: "Min. 8 characters",
                isPassword: true,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: 11.h),
              CommonButton(
                titleText: "Next",
                gradient: AppColors.primaryGradient,
                onTap: () => Get.toNamed(AppRoutes.kyc),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondaryColor,
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: "By signing up, you agree to our ",
                        ),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: AppColors.color2F80ED,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppColors.color2F80ED,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: "Already have an account? ",
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.login),
                    child: CommonText(
                      text: "Sign In",
                      fontSize: 14,
                      color: AppColors.color2F80ED,
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
