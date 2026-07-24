import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../component/common_appbar/common_appbar.dart';
import '../component/text/common_text.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_string.dart';

class MmuBylawsScreen extends StatelessWidget {
  const MmuBylawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: CommonAppBar(
        title: AppString.mmuBylawsTitle.tr,
        showBackButton: true,
      ),
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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: AppString.mmuDescription.tr,
                  fontSize: 14,
                  color: isDark ? Colors.white70 : AppColors.color333333,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 24.h),
                CommonText(
                  text: AppString.membershipLaws.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppColors.color333333,
                ),
                SizedBox(height: 12.h),
                CommonText(
                  text: AppString.membershipGuidelines.tr,
                  fontSize: 14.sp,
                  color: isDark ? Colors.white70 : AppColors.color333333,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 12.h),
                _buildBulletPoint(context, AppString.bylawBullet1.tr),
                _buildBulletPoint(context, AppString.bylawBullet2.tr),
                _buildBulletPoint(context, AppString.bylawBullet3.tr),
                _buildBulletPoint(context, AppString.bylawBullet4.tr),
                _buildBulletPoint(context, AppString.bylawBullet5.tr),
                _buildBulletPoint(context, AppString.bylawBullet6.tr),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBulletPoint(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              height: 5.h,
              width: 5.w,
              decoration: BoxDecoration(
                color: isDark ? Colors.white70 : Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CommonText(
              text: text,
              fontSize: 14.sp,
              color: isDark ? Colors.white70 : AppColors.color333333,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
