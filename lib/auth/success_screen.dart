import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.green, width: 3),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.green,
                        size: 50.sp,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CommonText(
                      text: "Success!",
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor,
                    ),
                    SizedBox(height: 12.h),
                    CommonText(
                      text: "Your account has been created successfully.\nWelcome to SaveCircle!",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryColor.withValues(alpha: 0.8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CommonButton(
                titleText: "Get Started",
                gradient: AppColors.primaryGradient,
                onTap: () => Get.offAllNamed(AppRoutes.login),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
