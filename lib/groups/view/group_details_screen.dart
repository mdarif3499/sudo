import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/route/app_routes.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/group_details_controller.dart';
import '../data/group_details_model.dart';
import 'package:intl/intl.dart';
import '../../component/other_widgets/common_skeleton.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupDetailsController controller = Get.put(GroupDetailsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return _buildSkeleton(context);
          }

          final details = controller.groupDetails.value;
          if (details == null || details.group == null) {
            return const Center(child: CommonText(text: "No details found"));
          }

          return Column(
            children: [
              _buildAppBar(context, controller),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      _buildSavingsCard(details),
                      SizedBox(height: 20.h),
                      _buildActionButtons(context),
                      SizedBox(height: 15.h),
                      _buildCurrentReceiverCard(context, details),
                      SizedBox(height: 25.h),
                      CommonText(
                        text: AppString.members,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
                      ),
                      SizedBox(height: 12.h),
                      _buildMembersList(context, details),
                      SizedBox(height: 20.h),
                      CommonText(
                        text: AppString.recentContributions,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
                      ),
                      SizedBox(height: 12.h),
                      _buildRecentContributions(context),
                      SizedBox(height: 20.h),
                      _buildNextContributionCard(context, details),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              CommonSkeleton(height: 40.r, width: 40.r, borderRadius: 20),
              SizedBox(width: 15.w),
              CommonSkeleton(height: 24.h, width: 150.w),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                CommonSkeleton(height: 200.h, width: double.infinity, borderRadius: 24),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(child: CommonSkeleton(height: 52.h, width: double.infinity, borderRadius: 14)),
                    SizedBox(width: 15.w),
                    Expanded(child: CommonSkeleton(height: 52.h, width: double.infinity, borderRadius: 14)),
                  ],
                ),
                SizedBox(height: 15.h),
                CommonSkeleton(height: 60.h, width: double.infinity, borderRadius: 8),
                SizedBox(height: 25.h),
                CommonSkeleton(height: 20.h, width: 100.w),
                SizedBox(height: 12.h),
                CommonSkeleton(height: 150.h, width: double.infinity, borderRadius: 20),
                SizedBox(height: 20.h),
                CommonSkeleton(height: 20.h, width: 150.w),
                SizedBox(height: 12.h),
                CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16),
                SizedBox(height: 20.h),
                CommonSkeleton(height: 120.h, width: double.infinity, borderRadius: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, GroupDetailsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final group = controller.groupDetails.value?.group;
    
    // Logic: Current User is Admin AND Status is Pending
    bool showStartButton = controller.isUserAdmin() && group?.status?.toLowerCase() == "pending";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.white12 : const Color(0xFFE0E0E0)),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20.sp,
                    color: isDark ? Colors.white : AppColors.black,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              const CommonText(
                text: AppString.groupDetails,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          if (showStartButton)
            Obx(() => CommonButton(
              titleText: "Start Group",
              buttonWidth: 110.w,
              buttonHeight: 38.h,
              buttonRadius: 10,
              isLoading: controller.isStarting.value,
              gradient: AppColors.primaryGradient,
              onTap: () => controller.startGroup(group!.id!),
            )),
        ],
      ),
    );
  }

  Widget _buildSavingsCard(GroupDetailsModel details) {
    final group = details.group!;
    
    double progressValue = 0.0;
    if (details.progress is int) {
      progressValue = (details.progress as int).toDouble() / 100;
    } else if (details.progress is double) {
      progressValue = (details.progress as double) / 100;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B44D1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: group.name ?? '',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.people_outline, color: Colors.white70, size: 18.sp),
              SizedBox(width: 6.w),
              CommonText(
                text: "${group.members?.length ?? 0} Members",
                fontSize: 14,
                color: Colors.white70,
              ),
            ],
          ),
          SizedBox(height: 25.h),
          const CommonText(
            text: AppString.totalPool,
            fontSize: 14,
            color: Colors.white70,
          ),
          CommonText(
            text: "\$${group.targetPoolAmount}",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 20.h),
          Stack(
            children: [
              Container(
                height: 10.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 10.h,
                    width: constraints.maxWidth * progressValue,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "${(progressValue * 100).toInt()}%",
                fontSize: 14,
                color: Colors.white,
              ),
              CommonText(
                text: "\$${group.contributionAmount} / \$${group.targetPoolAmount}",
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            titleText: AppString.invite,
            buttonHeight: 52.h,
            buttonRadius: 14,
            gradient: AppColors.primaryGradient,
            prefixIcon: Icon(
              Icons.person_add_alt_1_outlined,
              color: Colors.white,
              size: 20.sp,
            ),
            onTap: () => Get.toNamed(AppRoutes.inviteMembers),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: CommonButton(
            titleText: AppString.chat,
            titleColor: isDark ? Colors.white : AppColors.black,
            buttonColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
            borderColor: isDark ? AppColors.darkCardBorder : const Color(0xFFE0E0E0),
            buttonHeight: 52.h,
            buttonRadius: 14,
            prefixIcon: Icon(
              Icons.chat_bubble_outline,
              color: isDark ? Colors.white : AppColors.black,
              size: 20.sp,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.chat);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentReceiverCard(BuildContext context, GroupDetailsModel details) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String receiverName = "Not Assigned";
    if (details.currentReceiver != null) {
       if (details.currentReceiver is Map) {
         receiverName = details.currentReceiver['fullName'] ?? "N/A";
       } else {
         receiverName = details.currentReceiver.toString();
       }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF06D6A0).withValues(alpha: isDark ? 0.1 : 0.07),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF06D6A0).withValues(alpha: 0.20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonText(
            text: "Current Receiver",
            fontSize: 12,
            color: isDark ? Colors.white38 : const Color(0xFF828282),
          ),
          CommonText(
            text: receiverName,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF06D6A0),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList(BuildContext context, GroupDetailsModel details) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final membersCount = details.group?.members?.length ?? 0;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: membersCount == 0 
        ? Padding(
            padding: EdgeInsets.all(20.r),
            child: const Center(child: CommonText(text: "No members yet")),
          )
        : Column(
            children: [
              if (details.group?.admin != null)
                _buildMemberItem(
                  context,
                  details.group!.admin!.fullName ?? 'Admin',
                  "Admin",
                  "Active",
                  true,
                  (details.group!.admin!.fullName ?? 'A').substring(0, 1).toUpperCase(),
                  const Color(0xFFE3F2FD),
                  isLast: membersCount == 1,
                ),
            ],
          ),
    );
  }

  Widget _buildMemberItem(
    BuildContext context,
    String name,
    String amount,
    String status,
    bool isPaid,
    String initials,
    Color avatarColor, {
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: isDark ? Colors.white10 : Colors.grey.withValues(alpha: 0.1)),
              ),
      ),
      child: Row(
        children: [
          Container(
            height: 44.r,
            width: 44.r,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CommonText(
                text: initials,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF48C8FC),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: name,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : AppColors.primaryColor,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: amount,
                  fontSize: 13,
                  color: isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                isPaid ? Icons.check_circle_outline : Icons.access_time,
                size: 16.sp,
                color: isPaid
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFF2C94C),
              ),
              SizedBox(width: 5.w),
              CommonText(
                text: status,
                fontSize: 14,
                color: isPaid
                    ? const Color(0xFF27AE60)
                    : const Color(0xFFF2C94C),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentContributions(BuildContext context) {
    return Column(
      children: [
        _buildContributionItem(context, "Admin", "N/A", "N/A"),
      ],
    );
  }

  Widget _buildContributionItem(BuildContext context, String name, String date, String amount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: isDark ? Colors.white : AppColors.black,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: name,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : AppColors.black,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: date,
                  fontSize: 12,
                  color: isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C,
                ),
              ],
            ),
          ),
          CommonText(
            text: amount,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNextContributionCard(BuildContext context, GroupDetailsModel details) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final group = details.group!;
    
    String nextDate = "N/A";
    if (group.startDate != null) {
      nextDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(group.startDate!));
    }

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark 
            ? [AppColors.darkCardBg, AppColors.darkCardBg.withValues(alpha: 0.8)]
            : [const Color(0xFFFFFFFF), const Color(0xFFF2F2F7)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.12),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.18),
            spreadRadius: 0,
            blurRadius: 80,
            offset: const Offset(0, 40),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 48.r,
                width: 48.r,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEBF8FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: const Color(0xFF00ADEF),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: AppString.nextContribution,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    CommonText(
                      text: "Cycle ${details.currentCycle ?? 1}",
                      fontSize: 13,
                      color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
                    ),
                  ],
                ),
              ),
              CommonText(
                text: "\$${group.contributionAmount}",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "Due: $nextDate",
                fontSize: 14,
                color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.makePayment),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
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
                  child: const CommonText(
                    text: "Pay Now",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
