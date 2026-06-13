import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_icons.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Help & Support"),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // FAQ's Item
                    _buildSupportItem(
                      iconPath: AppIcons.faqs,
                      iconColor: const Color(0xFF4A7FE0),
                      bgColor: const Color(0xFFE8EFFF),
                      title: "FAQ's",
                      onTap: () => Get.toNamed(AppRoutes.faq),
                    ),
                    const Divider(height: 1, color: Color(0xFFE0E4ED)),
                    
                    // Privacy Policy Item
                    _buildSupportItem(
                      iconPath: AppIcons.privacy,
                      iconColor: const Color(0xFF10B981),
                      bgColor: const Color(0xFFE6F9F3),
                      title: "Privacy Policy",
                      onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                    ),
                    const Divider(height: 1, color: Color(0xFFE0E4ED)),
                    
                    // Terms & Condition Item
                    _buildSupportItem(
                      iconPath: AppIcons.terms,
                      iconColor: const Color(0xFF8B5CF6),
                      bgColor: const Color(0xFFF3E8FF),
                      title: "Terms & Condition",
                      onTap: () => Get.toNamed(AppRoutes.termsCondition),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // হেল্পার উইজেট প্রতিটি অপশনের জন্য
  Widget _buildSupportItem({
    required String iconPath,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        child: Row(
          children: [
            // আইকন কন্টেইনার (Circle)
            Container(
              height: 40.h,
              width: 40.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                iconPath,
                color: iconColor,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 16.w),
            // টেক্সট
            Expanded(
              child: CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1A1F36),
              ),
            ),
            // অ্যারো আইকন
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}
