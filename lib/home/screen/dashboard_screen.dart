import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/component/button/common_button.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_string.dart';
import '../../component/text/common_text.dart';
import '../controller/dashboard_controller.dart';
import '../controller/invitation_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../../component/other_widgets/common_skeleton.dart';
import 'package:intl/intl.dart';
import '../data/outstanding_contribution_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());
    final ProfileController profileController = Get.put(ProfileController());
    final InvitationController invitationController = Get.put(InvitationController());
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
          child: Obx(() {
            if (profileController.isLoading.value || controller.isDashboardLoading.value) {
              return _buildSkeleton(context);
            }

            final profile = profileController.profileData.value;
            final dashboard = controller.dashboardData.value;

            return RefreshIndicator(
              onRefresh: () async {
                await profileController.fetchProfile();
                await controller.fetchDashboardSummary();
                await controller.fetchOutstandingContributions();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: const AlwaysScrollableScrollPhysics(),
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
                        Row(
                          children: [
                            if (invitationController.pendingInvitations.isNotEmpty) SizedBox(width: 12.w),
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
                      ],
                    ),
                    SizedBox(height: 25.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: AppString.welcomeBackComma.tr,
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
                          titleText: AppString.newGroup.tr,
                          titleSize: 14,
                          buttonWidth: 150.w,
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

                    // Pending Invitation Prompt Card
                    Obx(() {
                      if (invitationController.pendingInvitations.isNotEmpty) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00ADEF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFF00ADEF).withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00ADEF),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.mail_outline, color: Colors.white, size: 20.sp),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: AppString.pendingInvitationsTitle.trParams({'count': invitationController.pendingInvitations.length.toString()}),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CommonText(
                                      text: AppString.newInvitationsDescription.trParams({'count': invitationController.pendingInvitations.length.toString()}),
                                      fontSize: 13,
                                      color: isDark ? Colors.white70 : Colors.black54,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.invitations),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00ADEF),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: CommonText(
                                    text: AppString.view.tr,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),

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
                                text: AppString.totalContribution.tr,
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
                            text: "\$${dashboard?.totalContribution ?? 0}",
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Small Stat Cards
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              AppString.totalSavings.tr,
                              "\$${dashboard?.totalSavings ?? 0}",
                              Icons.account_balance_wallet_outlined,
                              isDark ? AppColors.darkCardBg : const Color(0xFFE4FFF9),
                              isDark ? AppColors.darkCardBorder : const Color(0xFFAAFFED),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              AppString.activeGroups.tr,
                              "${dashboard?.activeGroups ?? 0}",
                              Icons.group_outlined,
                              isDark ? AppColors.darkCardBg : const Color(0xFFEAF9FF),
                              isDark ? AppColors.darkCardBorder : const Color(0xFFCAF0FF),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              AppString.thisMonth.tr,
                              "\$${dashboard?.thisMonthContribution ?? 0}",
                              Icons.calendar_today_outlined,
                              isDark ? AppColors.darkCardBg : const Color(0xFFE9FEFF),
                              isDark ? AppColors.darkCardBorder : const Color(0xFFB8FCFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Outstanding Contributions Section
                    Obx(() {
                      final outstanding = controller.outstandingData.value;
                      if (outstanding == null || 
                          ((outstanding.currentDues?.isEmpty ?? true) && 
                           (outstanding.overdues?.isEmpty ?? true))) {
                        return const SizedBox.shrink();
                      }

                      final allDues = [
                        ...(outstanding.overdues ?? []).map((e) => MapEntry(true, e)),
                        ...(outstanding.currentDues ?? []).map((e) => MapEntry(false, e)),
                      ];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: AppString.outstandingContributions.tr,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            bottom: 12,
                          ),
                          ...allDues.map((entry) {
                            final isOverdue = entry.key;
                            final due = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: _buildOutstandingCard(context, due, isOverdue),
                            );
                          }),
                        ],
                      );
                    }),


                    SizedBox(height: 25.h),

                    // Recent Activity Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: AppString.recentActivity.tr,
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
                                text: AppString.viewAll.tr,
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
                    if (dashboard?.last5Contributions == null || dashboard!.last5Contributions!.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: CommonText(text: AppString.noRecentActivity.tr, color: Colors.grey),
                        ),
                      )
                    else
                      ...dashboard.last5Contributions!.map((contribution) {
                        String formattedDate = "N/A";
                        if (contribution.paymentDate != null) {
                          formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(contribution.paymentDate!).toLocal());
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: _buildActivityItem(
                            context,
                            contribution.group?.name ?? "Unknown Group",
                            formattedDate,
                            "\$${contribution.amount ?? 0}",
                            AppString.complete.tr,
                          ),
                        );
                      }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          }),
        ),
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
            textAlign: TextAlign.center,
            color: isDark ? Colors.white60 : AppColors.textSecondary,
          ),
          CommonText(
            text: value,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
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

  Widget _buildOutstandingCard(BuildContext context, OutstandingContributionItem due, bool isOverdue) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String formattedDate = "N/A";
    if (due.dueDate != null) {
      formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(due.dueDate!).toLocal());
    }

    return Container(
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
                  color: isOverdue 
                      ? Colors.red.withValues(alpha: 0.1) 
                      : (isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFE3F2FD)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  isOverdue ? Icons.warning_amber_rounded : Icons.calendar_month,
                  color: isOverdue ? Colors.red : Colors.blue,
                  size: 24,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: isOverdue ? AppString.overdueContribution.tr : AppString.nextContribution.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isOverdue ? Colors.red : (isDark ? Colors.white : Colors.black),
                    ),
                    CommonText(
                      text: due.groupName ?? "Unknown Group",
                      fontSize: 13.sp,
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              CommonText(
                text: "\$${due.amount ?? 0}",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "${AppString.dueColon.tr} $formattedDate",
                fontSize: 14.sp,
                color: isOverdue ? Colors.red : (isDark ? Colors.white60 : AppColors.textSecondary),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.makePayment,
                    arguments: {
                      "id": due.groupId,
                      "amount": "\$${due.amount}",
                      "groupName": due.groupName ?? "N/A",
                      "dueDate": formattedDate,
                      "periodNumber": due.periodNumber,
                      "cycleNumber": due.cycleNumber,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: isOverdue 
                        ? const LinearGradient(colors: [Colors.red, Colors.deepOrange]) 
                        : AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CommonText(
                    text: AppString.payNow.tr,
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
