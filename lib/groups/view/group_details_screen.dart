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
              _buildAppBar(context),
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
                      _buildActionButtons(context, controller),
                      SizedBox(height: 15.h),
                      
                      // Replaced Current Receiver with Cycle Info Card
                      _buildCycleInfoCard(context, controller),
                      
                      SizedBox(height: 25.h),
                      
                      _buildPeriodHistoryHeader(context, controller),
                      SizedBox(height: 12.h),
                      _buildPeriodHistoryList(context, controller),
                      
                      SizedBox(height: 20.h),
                      
                      // Updated Pay Now logic to match period and cycle
                      _buildConditionalPaySection(context, controller, details),
                      
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

  Widget _buildCycleInfoCard(BuildContext context, GroupDetailsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      final history = controller.periodHistory.value;
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
              text: "Cycle Number",
              fontSize: 12,
              color: isDark ? Colors.white38 : const Color(0xFF828282),
            ),
            CommonText(
              text: "Cycle ${history?.cycleNumber ?? 1}",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF06D6A0),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildConditionalPaySection(BuildContext context, GroupDetailsController controller, GroupDetailsModel details) {
    // Current group state
    final currentPeriod = details.currentPeriod ?? 0;
    final currentCycle = details.currentCycle ?? 0;
    
    // History state currently viewed
    final selectedPeriod = controller.periodHistory.value?.periodNumber ?? 0;
    final selectedCycle = controller.periodHistory.value?.cycleNumber ?? 0;
    
    // Hiding logic:
    // 1. If looking at a future period (selected > current) -> Hide
    // 2. If same period but future cycle (selectedCycle > currentCycle) -> Hide
    // 3. If User is the receiver in this period -> Hide
    
    bool isFuturePeriod = selectedPeriod > currentPeriod;
    bool isFutureCycle = (selectedPeriod == currentPeriod) && (selectedCycle > currentCycle);
    
    bool canPay = details.group?.status?.toLowerCase() == "active" && 
                  !controller.isCurrentUserReceiver() && 
                  !isFuturePeriod && 
                  !isFutureCycle;

    if (canPay) {
      return _buildNextContributionCard(context, details);
    }
    return const SizedBox.shrink();
  }

  Widget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
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
    );
  }

  Widget _buildActionButtons(BuildContext context, GroupDetailsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final group = controller.groupDetails.value?.group;
    final status = group?.status?.toLowerCase() ?? "";
    final isAdmin = controller.isUserAdmin();
    
    final bool isFull = (group?.members?.length ?? 0) >= (group?.targetedMembers ?? 0);

    return Row(
      children: [
        if (status == "pending") ...[
          if (isFull && isAdmin)
            Expanded(
              child: Obx(() => CommonButton(
                    titleText: "Start Group",
                    buttonHeight: 52.h,
                    buttonRadius: 14,
                    isLoading: controller.isStarting.value,
                    gradient: AppColors.primaryGradient,
                    prefixIcon: Icon(Icons.play_arrow_outlined, color: Colors.white, size: 20.sp),
                    onTap: () => controller.startGroup(group!.id!),
                  )),
            )
          else if (!isFull)
            Expanded(
              child: CommonButton(
                titleText: AppString.invite,
                buttonHeight: 52.h,
                buttonRadius: 14,
                gradient: AppColors.primaryGradient,
                prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 20.sp),
                onTap: () => Get.toNamed(AppRoutes.inviteMembers),
              ),
            ),
          
          if ((isFull && isAdmin) || !isFull) SizedBox(width: 15.w),
        ],

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
            onTap: () => Get.toNamed(AppRoutes.chat),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodHistoryHeader(BuildContext context, GroupDetailsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: "Period History",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => controller.loadPreviousPeriod(),
                child: Icon(Icons.chevron_left, size: 24.sp, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Obx(() => CommonText(
                  text: "Period ${controller.periodHistory.value?.periodNumber ?? 1}",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                )),
              ),
              GestureDetector(
                onTap: () => controller.loadNextPeriod(),
                child: Icon(Icons.chevron_right, size: 24.sp, color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodHistoryList(BuildContext context, GroupDetailsController controller) {
    return Obx(() {
      if (controller.isHistoryLoading.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }

      final history = controller.periodHistory.value;
      if (history == null || history.members == null || history.members!.isEmpty) {
        return const Center(child: CommonText(text: "No history found for this period"));
      }

      return Column(
        children: history.members!.map((memberData) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildContributionItem(
              context,
              memberData.member?.fullName ?? "Unknown",
              memberData.status ?? "Pending",
              "\$${memberData.amount ?? 0}",
              memberData.paymentDate,
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildContributionItem(BuildContext context, String name, String status, String amount, String? date) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color statusColor;
    IconData statusIcon;
    
    switch (status.toLowerCase()) {
      case 'paid':
        statusColor = const Color(0xFF27AE60);
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case 'receiver':
        statusColor = Colors.blue;
        statusIcon = Icons.account_balance_wallet_outlined;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
    }

    String formattedDate = "Pending";
    if (date != null) {
      formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(date));
    } else if (status.toLowerCase() == 'receiver') {
      formattedDate = "Beneficiary";
    }

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
              color: statusColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 18.sp),
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
                  color: isDark ? Colors.white : Colors.black,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: formattedDate,
                  fontSize: 12,
                  color: isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: amount,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.primaryColor,
              ),
              CommonText(
                text: status.capitalizeFirst ?? '',
                fontSize: 11,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
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
                onTap: () => Get.toNamed(AppRoutes.makePayment, arguments: group.id),
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
