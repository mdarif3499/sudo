import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/common_appbar/common_appbar.dart';
import '../component/text/common_text.dart';
import '../utils/constants/app_colors.dart';

class MmuBylawsScreen extends StatelessWidget {
  const MmuBylawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "MMU Bylaws",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: "MMU is a community-driven fundraising platform designed to support members in times of need and create meaningful financial impact through collective contribution. Our goal is to build a trusted and transparent ecosystem where members can contribute, request support, and stay connected within a supportive network.\nWe believe in unity, accountability, and compassion—ensuring that every contribution makes a real difference. MMU empowers individuals by providing a simple and reliable way to manage funds, participate in community support, and access financial aid when needed.",
              fontSize: 14,
              color: AppColors.color333333,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 24.h),
            CommonText(
              text: "Membership Laws",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.color333333,
            ),
            SizedBox(height: 12.h),
            CommonText(
              text: "To maintain a fair and trustworthy environment, all members are expected to follow these guidelines:",
              fontSize: 14.sp,
              color: AppColors.color333333,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 12.h),
            _buildBulletPoint("Members must provide accurate and valid information during registration."),
            _buildBulletPoint("All contributions and transactions must follow the platform's rules and guidelines."),
            _buildBulletPoint("Any misuse, fraud, or misleading activity may result in account suspension or removal."),
            _buildBulletPoint("Fund requests should be genuine, verified, and aligned with the platform's purpose."),
            _buildBulletPoint("Members are encouraged to respect others and maintain a supportive community environment."),
            _buildBulletPoint("The platform reserves the right to update policies and take necessary actions."),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
  Widget _buildBulletPoint(String text) {
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
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CommonText(
              text: text,
              fontSize: 14.sp,
              color: AppColors.color333333,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
