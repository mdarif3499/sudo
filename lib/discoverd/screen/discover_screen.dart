import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../controller/discover_controller.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  final DiscoverController controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: CommonText(
                        text: "Search your favourite groups",
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CommonTextField(
                      controller: controller.searchController,
                      onChanged: (value) => controller.filterGroups(value),
                      hintText: "Search groups...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      fillColor: const Color(0xFF1A1A1A).withValues(alpha: 0.05),
                      borderRadius: 16,
                    ),
                    SizedBox(height: 24.h),
                    CommonText(
                      text: "All Public Circles",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (controller.filteredGroups.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: CommonText(
                              text: "No groups found",
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredGroups.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final group = controller.filteredGroups[index];
                          return _buildGroupCard(
                            title: group.title,
                            members: group.members,
                            frequency: group.frequency,
                            target: group.target,
                            perMember: group.perMember,
                            iconColor: group.iconColor,
                            icon: group.icon,
                          );
                        },
                      );
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: "Discover",
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.createGroup),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      CommonText(
                        text: "New Group",
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard({
    required String title,
    required String members,
    required String frequency,
    required String target,
    required String perMember,
    required Color iconColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: const Color(0xFF00ADEF), size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.people_outline,
                            color: Colors.grey, size: 14.sp),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: "$members  •  $frequency",
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1, color: Color(0xFFF2F2F7)),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: "Target", fontSize: 12.sp, color: Colors.grey),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: target,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: "Per Member", fontSize: 12.sp, color: Colors.grey),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: perMember,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              CommonButton(
                titleText: "Join",
                buttonWidth: 70, // Fixed width added to resolve layout error
                buttonHeight: 36.h,
                buttonRadius: 8,
                gradient: AppColors.primaryGradient,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
