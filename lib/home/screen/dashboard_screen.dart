import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../component/text/common_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppImages.splash, height: 32.h),
                      SizedBox(width: 6.w),
                      Image.asset(AppImages.sudo, height: 16.h),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.notification),
                    child: Image.asset(
                      AppIcons.notification,
                      height: 47.h,
                      width: 47.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),

              // Welcome and New Group Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Welcome back,",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                      CommonText(
                        text: "John Doe",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondaryColor7C7C7C,
                      ),
                    ],
                  ),
                  CommonButton(
                    titleText: "New Group",
                    buttonWidth: 130.w,
                    buttonHeight: 45.h,
                    buttonRadius: 12,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00A3E0), Color(0xFF4A44D1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.createGroup),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // Total Contribution Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFdee8f9), Color(0xFFe8f6f3)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08), // 8% opacity
                      blurRadius: 12,
                      spreadRadius: -2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Total Contribution",
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        Icon(
                          Icons.trending_up,
                          color: AppColors.textPrimary,
                          size: 24.r,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text: "\$12,450",
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Small Stat Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "Total Savings",
                      "\$12,450",
                      Icons.account_balance_wallet_outlined,
                      const Color(0xFFE4FFF9),
                      const Color(0xFFAAFFED),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildStatCard(
                      "Active Groups",
                      "4",
                      Icons.group_outlined,
                      const Color(0xFFEAF9FF),
                      const Color(0xFFCAF0FF),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildStatCard(
                      "This Month",
                      "\$850",
                      Icons.calendar_today_outlined,
                      const Color(0xFFE9FEFF),
                      const Color(0xFFB8FCFF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Next Contribution Card
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "Next Contribution",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              CommonText(
                                text: "Family Savings",
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                        CommonText(
                          text: "\$200",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Due: Jun 15, 2026",
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        _buildGradientButton("Pay Now", 100.w, 40.h),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),

              // Recent Activity Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "Recent Activity",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        CommonText(
                          text: "View All",
                          fontSize: 14.sp,
                          color: Colors.blue,
                        ),
                        Icon(Icons.north_east, size: 14.r, color: Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              _buildActivityItem(
                "Family Savings",
                "Today, 2:30 PM",
                "\$200",
                "completed",
              ),
              SizedBox(height: 10.h),
              _buildActivityItem(
                "Friends Circle",
                "Yesterday",
                "\$150",
                "completed",
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color bgColor,
    Color bdrColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.r),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: bdrColor, width: 1.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: Colors.blueGrey),
          SizedBox(height: 10.h),
          CommonText(
            text: title,
            fontSize: 11.sp,
            color: AppColors.textSecondary,
          ),
          CommonText(text: value, fontSize: 15.sp, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String date,
    String amount,
    String status,
  ) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Icons.trending_up, color: Colors.blueGrey, size: 24.r),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                CommonText(
                  text: date,
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor7C7C7C,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: amount,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              CommonText(text: status, fontSize: 11.sp, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(String text, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: CommonText(
          text: text,
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
