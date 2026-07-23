import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
import '../../component/text/common_text.dart';
import '../../component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../controller/groups_controller.dart';
import '../data/group_model.dart';
import 'package:intl/intl.dart';
import '../../component/other_widgets/common_skeleton.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupsController controller = Get.put(GroupsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "My Groups",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      CommonButton(
                        titleText: "New Group",
                        titleSize: 12,
                        buttonWidth: 130.w,
                        buttonHeight: 45.h,
                        buttonRadius: 12,
                        gradient: AppColors.primaryGradient,
                        prefixIcon: Icon(Icons.add, color: Colors.white, size: 20.sp),
                        onTap: () => Get.toNamed(AppRoutes.createGroup),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.notification),
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCardBg : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
                          ),
                          child: Icon(Icons.notifications_none, color: Colors.blue, size: 24.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            CommonText(
              text: "Manage your saving groups",
              fontSize: 14.sp,
              color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
            ),
            SizedBox(height: 20.h),

            // Groups List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: 3,
                    itemBuilder: (context, index) => _buildSkeletonCard(context),
                  );
                }
                
                if (controller.groupsList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group_off_outlined, size: 64.sp, color: Colors.grey),
                        SizedBox(height: 16.h),
                        CommonText(text: "No groups found", fontSize: 16.sp, color: Colors.grey),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchMyGroups(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: controller.groupsList.length,
                    itemBuilder: (context, index) {
                      final group = controller.groupsList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.groupDetails, arguments: group.id),
                          child: _buildGroupCard(context, group: group),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Container(
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBg : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonSkeleton(height: 54.h, width: 54.w, borderRadius: 27),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonSkeleton(height: 18.h, width: 120.w),
                      SizedBox(height: 8.h),
                      CommonSkeleton(height: 14.h, width: 80.w),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonSkeleton(height: 14.h, width: 60.w),
                CommonSkeleton(height: 14.h, width: 30.w),
              ],
            ),
            SizedBox(height: 8.h),
            CommonSkeleton(height: 8.h, width: double.infinity, borderRadius: 10),
            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [CommonSkeleton(height: 12.h, width: 50.w), SizedBox(height: 4.h), CommonSkeleton(height: 16.h, width: 60.w)]),
                Column(children: [CommonSkeleton(height: 12.h, width: 50.w), SizedBox(height: 4.h), CommonSkeleton(height: 16.h, width: 60.w)]),
                Column(children: [CommonSkeleton(height: 12.h, width: 50.w), SizedBox(height: 4.h), CommonSkeleton(height: 16.h, width: 60.w)]),
              ],
            ),
            SizedBox(height: 20.h),
            CommonSkeleton(height: 24.h, width: 70.w, borderRadius: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, {required GroupModel group}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    double progressValue = 0.0;
    if (group.progress is int) {
      progressValue = (group.progress as int).toDouble() / 100;
    } else if (group.progress is double) {
      progressValue = (group.progress as double) / 100;
    }

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.09),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54.h,
                width: 54.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFe9f8fe),
                ),
                child: Center(
                  child: Image.asset(AppImages.splash, height: 32.h),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: group.name,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        Icon(Icons.people_outline, size: 16.sp, color: Colors.grey),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: "${group.membersCount} members",
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey.shade400),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "Progress",
                fontSize: 14.sp,
                color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
              ),
              CommonText(
                text: "${(progressValue * 100).toInt()}%",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 8.h,
              backgroundColor: isDark ? Colors.white10 : Colors.grey.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF19CA77)),
            ),
          ),
          SizedBox(height: 10.h),
          Divider(color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(context, "Pool Total", "\$${group.poolTotal}"),
              _buildStatItem(context, "My Share", "\$${group.myShare}"),
              _buildStatItem(
                context, 
                "Next Due", 
                group.nextDue != null ? DateFormat('MMM dd').format(DateTime.parse(group.nextDue!)) : "N/A"
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: group.status.toLowerCase() == 'active' 
                  ? const Color(0xFFE8F9F1) 
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CommonText(
              text: group.status.capitalizeFirst ?? '',
              fontSize: 12.sp,
              color: group.status.toLowerCase() == 'active' 
                  ? const Color(0xFF19CA77) 
                  : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: 12.sp,
          color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
        ),
        SizedBox(height: 4.h),
        CommonText(text: value, fontSize: 16.sp, fontWeight: FontWeight.w400),
      ],
    );
  }
}
