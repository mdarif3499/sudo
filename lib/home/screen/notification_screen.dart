import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black, size: 20.sp),
            ),
          ),
        ),
        title: CommonText(
          text: "Notifications",
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: "2 unread",
                  fontSize: 14.sp,
                  color: isDark ? Colors.white60 : Colors.grey,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const CommonText(
                    text: "Mark all as read",
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _buildNotificationItem(
                  context,
                  title: "Payment Reminder",
                  description: "Your contribution of \$200 is due in 2 days for Family Savings",
                  time: "2 hours ago",
                  icon: Icons.attach_money,
                  iconBgColor: isDark ? const Color(0xFF2C2510) : const Color(0xFFFFF8E1),
                  iconColor: Colors.orange,
                  isUnread: true,
                  hasGradientBorder: true,
                ),
                SizedBox(height: 15.h),
                _buildNotificationItem(
                  context,
                  title: "New Member Joined",
                  description: "Sarah Williams joined Wedding Fund group",
                  time: "5 hours ago",
                  icon: Icons.person_outline,
                  iconBgColor: isDark ? const Color(0xFF1A1C2E) : const Color(0xFFE8EAF6),
                  iconColor: Colors.indigo,
                  isUnread: true,
                  hasGradientBorder: true,
                ),
                SizedBox(height: 15.h),
                _buildNotificationItem(
                  context,
                  title: "Payment Successful",
                  description: "Your \$150 contribution to Friends Circle was processed",
                  time: "1 day ago",
                  icon: Icons.check_circle_outline,
                  iconBgColor: isDark ? const Color(0xFF0E2411) : const Color(0xFFE8F5E9),
                  iconColor: Colors.green,
                  isUnread: false,
                ),
                SizedBox(height: 15.h),
                _buildNotificationItem(
                  context,
                  title: "Payout Received",
                  description: "You received \$1,500 from Wedding Fund",
                  time: "2 days ago",
                  icon: Icons.trending_up,
                  iconBgColor: isDark ? const Color(0xFF21132B) : const Color(0xFFF3E5F5),
                  iconColor: Colors.purple,
                  isUnread: false,
                ),
                SizedBox(height: 15.h),
                _buildNotificationItem(
                  context,
                  title: "Group Update",
                  description: "Family Savings reached 75% of target amount",
                  time: "3 days ago",
                  icon: Icons.people_outline,
                  iconBgColor: isDark ? const Color(0xFF0D1E2E) : const Color(0xFFE3F2FD),
                  iconColor: Colors.blue,
                  isUnread: false,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    bool isUnread = false,
    bool hasGradientBorder = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            if (hasGradientBorder)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4.w,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF04A1CD), Color(0xFF3B44D1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 24.sp),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: title,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            if (isUnread)
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        CommonText(
                          text: description,
                          fontSize: 13.sp,
                          color: isDark ? Colors.white60 : Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        CommonText(
                          text: time,
                          fontSize: 12.sp,
                          color: isDark ? Colors.white38 : Colors.grey.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
