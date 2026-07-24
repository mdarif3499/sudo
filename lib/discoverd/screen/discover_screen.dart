import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../controller/discover_controller.dart';
import '../data/discover_group_model.dart';
import '../../component/other_widgets/common_skeleton.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverController controller = Get.put(DiscoverController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
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
          child: Column(
            children: [
            _buildHeader(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchAllGroups(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Center(
                        child: CommonText(
                          text: AppString.searchFavouriteGroups.tr,
                          fontSize: 16,
                          color: isDark ? Colors.white38 : Colors.grey,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CommonTextField(
                        controller: controller.searchController,
                        onChanged: (value) => controller.filterGroups(value),
                        hintText: AppString.searchGroupsHint.tr,
                        prefixIcon: Icon(Icons.search, color: isDark ? Colors.white38 : Colors.grey),
                        borderRadius: 16,
                      ),
                      SizedBox(height: 24.h),
                      CommonText(
                        text: AppString.allPublicCircles.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 16.h),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) => _buildSkeletonCard(context),
                          );
                        }

                        if (controller.filteredGroups.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40.h),
                              child: CommonText(
                                text: AppString.noGroupsFound.tr,
                                fontSize: 14,
                                color: isDark ? Colors.white38 : Colors.grey,
                              ),
                            ),
                          );
                        }
                        
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.filteredGroups.length,
                          itemBuilder: (context, index) {
                            final group = controller.filteredGroups[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.groupDetails, arguments: group.id),
                                child: _buildGroupCard(context, group: group),
                              ),
                            );
                          },
                        );
                      }),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildSkeletonCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBg : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CommonSkeleton(height: 44.r, width: 44.r, borderRadius: 12),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonSkeleton(height: 16.h, width: 150.w),
                      SizedBox(height: 8.h),
                      CommonSkeleton(height: 12.h, width: 100.w),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF2F2F7)),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonSkeleton(height: 12.h, width: 40.w),
                      SizedBox(height: 4.h),
                      CommonSkeleton(height: 16.h, width: 60.w),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonSkeleton(height: 12.h, width: 60.w),
                      SizedBox(height: 4.h),
                      CommonSkeleton(height: 16.h, width: 60.w),
                    ],
                  ),
                ),
                CommonSkeleton(height: 36.h, width: 70.w, borderRadius: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: AppString.discover.tr,
            fontSize: 24,
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
                        text: AppString.newGroup.tr,
                        color: Colors.white,
                        fontSize: 12,
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
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  size: 20.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, {required DiscoverGroupModel group}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
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
                  color: const Color(0xFFE8F1FF).withValues(alpha: isDark ? 0.1 : 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Icon(Icons.group, color: Color(0xFF00ADEF), size: 24),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: group.name ?? "N/A",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.people_outline,
                            color: isDark ? Colors.white38 : Colors.grey, size: 14.sp),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: "${group.members?.length ?? 0} members  •  ${group.paymentFrequency?.capitalizeFirst ?? "N/A"}",
                          fontSize: 12,
                          color: isDark ? Colors.white38 : Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF2F2F7)),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: AppString.target.tr, fontSize: 12, color: isDark ? Colors.white38 : Colors.grey),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: "\$${group.targetPoolAmount}",
                      fontSize: 16,
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
                        text: AppString.perMember.tr, fontSize: 12, color: isDark ? Colors.white38 : Colors.grey),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: "\$${group.contributionAmount}",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              CommonButton(
                titleText: AppString.join.tr,
                buttonWidth: 70,
                buttonHeight: 36,
                padding: EdgeInsets.zero,
                buttonRadius: 8,
                gradient: AppColors.primaryGradient,
                onTap: () => _showJoinConfirmation(context, group),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showJoinConfirmation(BuildContext context, DiscoverGroupModel group) {
    final controller = Get.find<DiscoverController>();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CommonText(text: AppString.joinGroupTitle.tr, fontSize: 18, fontWeight: FontWeight.bold),
        content: CommonText(
          text: AppString.joinConfirmation.trParams({'name': group.name ?? ""}),
          fontSize: 14,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CommonText(text: AppString.cancel.tr, color: Colors.grey),
          ),
          Obx(() => controller.isJoining.value 
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              )
            : TextButton(
                onPressed: () async {
                  await controller.joinGroup(group.id!);
                  Get.back(); // Close dialog
                },
                child: CommonText(text: AppString.joinNow.tr, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
          ),
        ],
      ),
    );
  }
}
