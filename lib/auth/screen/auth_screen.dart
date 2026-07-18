import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
import '../../config/route/app_routes.dart';
import '../controller/sign_in_controller.dart';

class AuthScreen extends StatelessWidget {
   AuthScreen({super.key});

  var controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const Spacer(flex: 2),
                
                Image.asset(
                  AppImages.splash,
                  height: 110.h,
                  width: 110.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                Image.asset(
                  AppImages.sudo,
                  width: 150.w,
                  height: 32.h,
                  fit: BoxFit.contain,
                  color: isDark ? Colors.white : null,
                ),
                SizedBox(height: 16.h),
                Image.asset(
                  AppImages.sudoText, 
                  height: 8.h,
                  width: 220.w,
                  fit: BoxFit.contain,
                  color: isDark ? Colors.white70 : null,
                ),
                
                const Spacer(flex: 2),

                // Feature Cards
                _buildFeatureCard(
                  context: context,
                  title: 'Build wealth together',
                  subtitle: 'Join savings circles, contribute regularly, and achieve your financial goals faster.',
                ),
                SizedBox(height: 16.h),
                _buildFeatureCard(
                  context: context,
                  title: '100% Secure',
                  subtitle: 'Bank-level encryption and transparent tracking for complete peace of mind.',
                ),

                const Spacer(flex: 3),

                // Buttons Section
                CommonButton(
                  titleText: 'Create Account',
                  gradient: AppColors.primaryGradient,
                  onTap: () {
                     Get.toNamed(AppRoutes.register);
                  },
                ),
                SizedBox(height: 12.h),
                CommonButton(
                  titleText: 'Sign In',
                  buttonColor: isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.white,
                  titleColor: isDark ? Colors.white : AppColors.textPrimary,
                  borderColor: isDark ? Colors.white24 : Colors.grey.shade300,
                  onTap: () {
                     Get.toNamed(AppRoutes.login);
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({required BuildContext context, required String title, required String subtitle}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFE0E4ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: subtitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white70 : AppColors.textSecondaryColor,
            height: 1.5,
          ),
        ],
      ),
    );
  }
}
