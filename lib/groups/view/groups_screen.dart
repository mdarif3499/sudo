import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../component/text/common_text.dart';
import '../../component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../controller/groups_controller.dart';
import '../data/group_model.dart';

class GroupsScreen extends StatelessWidget {
  GroupsScreen({super.key});

  final GroupsController controller = Get.put(GroupsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF), // Light background
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Header: Title, New Group Button, Notification
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "My Groups",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.notification),
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue.withValues(alpha: 0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.blue,
                            size: 24.sp,
                          ),
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
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondaryColor7C7C7C,
            ),
            SizedBox(height: 20.h),

            // Groups List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.groupsList.length,
                  itemBuilder: (context, index) {
                    final group = controller.groupsList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.groupDetails),
                        child: _buildGroupCard(group: group),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard({required GroupModel group}) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFe9f8fe),
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.splash,
                    height: 32.h,
                  ), // Logo placeholder
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
                        Icon(
                          Icons.people_outline,
                          size: 16.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: "${group.members} members",
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey.shade400,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "Progress",
                fontSize: 14.sp,
                color: AppColors.textSecondaryColor7C7C7C,
              ),
              CommonText(
                text: group.percentage,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: group.progress,
              minHeight: 8.h,
              backgroundColor: Colors.grey.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(group.progressColor),
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(color: Color(0xFFE0E4ED)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Pool Total", group.poolTotal),
              _buildStatItem("My Share", group.myShare),
              _buildStatItem("Next Due", group.nextDue),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F9F1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CommonText(
              text: group.status,
              fontSize: 12.sp,
              color: const Color(0xFF19CA77),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: 12.sp,
          color: AppColors.textSecondaryColor7C7C7C,
        ),
        SizedBox(height: 4.h),
        CommonText(text: value, fontSize: 16.sp, fontWeight: FontWeight.w400),
      ],
    );
  }
}
