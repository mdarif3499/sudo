import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/route/app_routes.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/groups_controller.dart';
import '../data/group_model.dart';

class GroupDetailsScreen extends StatelessWidget {
  final int groupIndex;

  const GroupDetailsScreen({super.key, this.groupIndex = 0});

  @override
  Widget build(BuildContext context) {
    final GroupsController controller = Get.put(GroupsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.groupsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final group = controller.groupsList[groupIndex];

          return Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      _buildSavingsCard(group),
                      SizedBox(height: 20.h),
                      _buildActionButtons(),
                      SizedBox(height: 15.h),
                      _buildContributionTrends(),
                      SizedBox(height: 25.h),
                      CommonText(
                        text: AppString.members,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4F4F4F),
                      ),
                      SizedBox(height: 12.h),
                      _buildMembersList(group),
                      SizedBox(height: 20.h),
                      CommonText(
                        text: AppString.recentContributions,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4F4F4F),
                      ),
                      SizedBox(height: 12.h),
                      _buildRecentContributions(),
                      SizedBox(height: 20.h),
                      _buildNextContributionCard(group),
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

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          CommonText(
            text: AppString.groupDetails,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsCard(GroupModel group) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
            text: group.name,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.people_outline, color: Colors.white70, size: 18.sp),
              SizedBox(width: 6.w),
              CommonText(
                text: "${group.members} Members",
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ],
          ),
          SizedBox(height: 25.h),
          CommonText(
            text: AppString.totalPool,
            fontSize: 14.sp,
            color: Colors.white70,
          ),
          CommonText(
            text: group.poolTotal,
            fontSize: 32.sp,
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
                    width: constraints.maxWidth * group.progress,
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
                text: group.percentage,
                fontSize: 14.sp,
                color: Colors.white,
              ),
              CommonText(
                text: "${group.myShare} / ${group.poolTotal}",
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            titleText: AppString.invite,
            buttonHeight: 52.h,
            buttonRadius: 14,
            gradient: const LinearGradient(
              colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
            ),
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
            titleColor: AppColors.black,
            buttonColor: Colors.white,
            borderColor: const Color(0xFFE0E0E0),
            buttonHeight: 52.h,
            buttonRadius: 14,
            prefixIcon: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.black,
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

  Widget _buildContributionTrends() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                text: AppString.contributionTrends,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF242424),
              ),
              Icon(
                Icons.trending_up,
                color: const Color(0xFF242424),
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar("Jan", 0.7),
              _buildBar("Feb", 0.75),
              _buildBar("Mar", 0.7),
              _buildBar("Apr", 0.72),
              _buildBar("May", 0.7),
              _buildBar("Jun", 0.5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String month, double heightFactor) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 90.h * heightFactor,
          decoration: BoxDecoration(
            color: const Color(0xFF48C8FC),
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        SizedBox(height: 10.h),
        CommonText(
          text: month,
          fontSize: 12.sp,
          color: const Color(0xFF828282),
        ),
      ],
    );
  }

  Widget _buildMembersList(GroupModel group) {
    final members = group.membersList ?? [];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return _buildMemberItem(
            member.name,
            member.amount,
            member.status,
            member.isPaid,
            member.initials,
            member.avatarColor,
            isLast: index == members.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildMemberItem(
    String name,
    String amount,
    String status,
    bool isPaid,
    String initials,
    Color avatarColor, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
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
                fontSize: 14.sp,
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: amount,
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryColor7C7C7C,
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
                fontSize: 14.sp,
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

  Widget _buildRecentContributions() {
    return Column(
      children: [
        _buildContributionItem("John Doe", "Jun 1, 2026", "\$200"),
        SizedBox(height: 12.h),
        _buildContributionItem("Jane Smith", "Jun 1, 2026", "\$200"),
        SizedBox(height: 12.h),
        _buildContributionItem("All Members", "May 1, 2026", "\$800"),
      ],
    );
  }

  Widget _buildContributionItem(String name, String date, String amount) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.black,
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: date,
                  fontSize: 12.sp,
                  color: AppColors.textSecondaryColor7C7C7C,
                ),
              ],
            ),
          ),
          CommonText(
            text: amount,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNextContributionCard(GroupModel group) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF2F2F7)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.12),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.18),
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
                  color: const Color(0xFFEBF8FF),
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
                    CommonText(
                      text: AppString.nextContribution,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: "Due by ${group.nextDue}",
                      fontSize: 13.sp,
                      color: const Color(0xFF828282),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CommonButton(
            titleText: "Pay ${group.myShare}",
            buttonHeight: 54.h,
            gradient: const LinearGradient(
              colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
            ),
            onTap: () {
              Get.toNamed(
                AppRoutes.makePayment,
                arguments: {
                  'amount': group.myShare,
                  'groupName': group.name,
                  'dueDate': group.nextDue,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
