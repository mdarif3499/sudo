import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../data/group_details_model.dart';
import '../../component/text/common_text.dart';

class GroupSavingsCard extends StatelessWidget {
  final GroupDetailsModel details;

  const GroupSavingsCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText(
                  text: group.name ?? '',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.people_outline, color: Colors.white70, size: 18.sp),
                  SizedBox(width: 6.w),
                  CommonText(
                    text: "${group.members?.length ?? 0} / ${group.targetedMembers ?? 0} ${AppString.members.tr}",
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.totalPool.tr,
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    CommonText(
                      text: "\$${group.targetPoolAmount}",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60.h,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                color: Colors.white.withValues(alpha: 0.2),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonText(
                      text: AppString.contributionAmountCycle.tr,
                      fontSize: 12,
                      color: Colors.white70,
                      textAlign: TextAlign.end,
                    ),
                    CommonText(
                      text: "${group.contributionAmount}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.end,
                    ),
                    Divider(height: 16.h, color: Colors.white.withValues(alpha: 0.2)),
                    CommonText(
                      text: "${details.currentCycle} / ${group.totalCycles} ${AppString.cycles.tr}",
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.end,
                    ),
                    CommonText(
                      text: group.paymentFrequency?.capitalizeFirst ?? '',
                      fontSize: 12,
                      color: Colors.white70,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
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
                text: "${(progressValue * 100).toInt()}% ${AppString.complete.tr}",
                fontSize: 14,
                color: Colors.white,
              ),
              CommonText(
                text: "\$${details.currentPeriodCollectedAmount ?? 0} / \$${details.currentPeriodExpectedAmount ?? 0}",
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
}
