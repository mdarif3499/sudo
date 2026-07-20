import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../component/text/common_text.dart';
import '../controller/dashboard_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../../component/other_widgets/common_skeleton.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return _buildSkeleton(context);
          }

          final profile = profileController.profileData.value;

          return SingleChildScrollView(
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
                        Image.asset(
                          AppImages.sudo, 
                          height: 16.h,
                          color: isDark ? Colors.white : null,
                        ),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Welcome back,",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white70 : AppColors.textPrimary,
                          ),
                          CommonText(
                            text: profile?['fullName'] ?? "User",
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textSecondaryColor7C7C7C,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CommonButton(
                      titleText: "New Group",
                      titleSize: 16,
                      buttonWidth: 140.w,
                      buttonHeight: 45.h,
                      buttonRadius: 12,
                      gradient: AppColors.primaryGradient,
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
                    gradient: isDark 
                      ? LinearGradient(
                          colors: [
                            AppColors.darkCardBg,
                            AppColors.darkCardBg.withValues(alpha: 0.8),
                          ],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFFDEE8F9), Color(0xFFE8F6F3)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                    borderRadius: BorderRadius.circular(12.r),
                    border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
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
                            color: isDark ? Colors.white70 : AppColors.textSecondary,
                          ),
                          Icon(
                            Icons.trending_up,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                            size: 24.r,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: "\$12,450",
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
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
                        context,
                        "Total Savings",
                        "\$12,450",
                        Icons.account_balance_wallet_outlined,
                        isDark ? AppColors.darkCardBg : const Color(0xFFE4FFF9),
                        isDark ? AppColors.darkCardBorder : const Color(0xFFAAFFED),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        "Active Groups",
                        "4",
                        Icons.group_outlined,
                        isDark ? AppColors.darkCardBg : const Color(0xFFEAF9FF),
                        isDark ? AppColors.darkCardBorder : const Color(0xFFCAF0FF),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        "This Month",
                        "\$850",
                        Icons.calendar_today_outlined,
                        isDark ? AppColors.darkCardBg : const Color(0xFFE9FEFF),
                        isDark ? AppColors.darkCardBorder : const Color(0xFFB8FCFF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Next Contribution Card
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBg : Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
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
                              color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: const Icon(
                              Icons.calendar_month,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CommonText(
                                  text: "Next Contribution",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                CommonText(
                                  text: "Family Savings",
                                  fontSize: 13.sp,
                                  color: isDark ? Colors.white60 : AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                          const CommonText(
                            text: "\$200",
                            fontSize: 18,
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
                            color: isDark ? Colors.white60 : AppColors.textSecondary,
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
                    const CommonText(
                      text: "Recent Activity",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.paymentHistory);
                      },
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
                  context,
                  "Family Savings",
                  "Today, 2:30 PM",
                  "\$200",
                  "completed",
                ),
                SizedBox(height: 10.h),
                _buildActivityItem(
                  context,
                  "Friends Circle",
                  "Yesterday",
                  "\$150",
                  "completed",
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonSkeleton(height: 32.h, width: 100.w),
              CommonSkeleton(height: 47.r, width: 47.r, borderRadius: 24),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonSkeleton(height: 14.h, width: 100.w),
                  SizedBox(height: 4.h),
                  CommonSkeleton(height: 24.h, width: 150.w),
                ],
              ),
              CommonSkeleton(height: 45.h, width: 140.w, borderRadius: 12),
            ],
          ),
          SizedBox(height: 10.h),
          CommonSkeleton(height: 120.h, width: double.infinity, borderRadius: 12),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: CommonSkeleton(height: 100.h, width: double.infinity, borderRadius: 20)),
              SizedBox(width: 15.w),
              Expanded(child: CommonSkeleton(height: 100.h, width: double.infinity, borderRadius: 20)),
              SizedBox(width: 15.w),
              Expanded(child: CommonSkeleton(height: 100.h, width: double.infinity, borderRadius: 20)),
            ],
          ),
          SizedBox(height: 20.h),
          CommonSkeleton(height: 150.h, width: double.infinity, borderRadius: 24),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonSkeleton(height: 20.h, width: 120.w),
              CommonSkeleton(height: 14.h, width: 60.w),
            ],
          ),
          SizedBox(height: 15.h),
          CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16),
          SizedBox(height: 10.h),
          CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color bgColor,
    Color bdrColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.r),
      decoration: BoxDecoration(
        color: isDark ? bgColor : bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: bdrColor, width: 1.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: isDark ? Colors.white70 : Colors.blueGrey),
          SizedBox(height: 10.h),
          CommonText(
            text: title,
            fontSize: 11.sp,
            color: isDark ? Colors.white60 : AppColors.textSecondary,
          ),
          CommonText(text: value, fontSize: 15.sp, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String date,
    String amount,
    String status,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFE5E7EB), width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Icons.trending_up, color: isDark ? Colors.white70 : Colors.blueGrey, size: 24.r),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                CommonText(
                  text: date,
                  fontSize: 12.sp,
                  color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
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
              CommonText(text: status, fontSize: 11.sp, color: isDark ? Colors.white38 : Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(String text, double width, double height) {
    return GestureDetector(
      onTap: (){
          Get.toNamed(AppRoutes.makePayment);

      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.2),
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
      ),
    );
  }
}
