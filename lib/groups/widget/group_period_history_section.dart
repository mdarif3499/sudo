import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/group_details_controller.dart';

class GroupPeriodHistorySection extends StatelessWidget {
  const GroupPeriodHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupDetailsController controller = Get.find<GroupDetailsController>();
    
    return Column(
      children: [
        _buildHeader(context, controller),
        SizedBox(height: 12.h),
        _buildList(context, controller),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, GroupDetailsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: AppString.periodHistory.tr,
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
                  text: "${AppString.period.tr} ${controller.periodHistory.value?.periodNumber ?? 1}",
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

  Widget _buildList(BuildContext context, GroupDetailsController controller) {
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
        return Center(child: CommonText(text: AppString.noGroupsFound.tr));
      }

      return Column(
        children: history.members!.map((memberData) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildContributionItem(
              context,
              memberData.member?.fullName ?? AppString.unknown.tr,
              memberData.status ?? AppString.pending.tr,
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
    String displayStatus = status;

    switch (status.toLowerCase()) {
      case 'paid':
        statusColor = const Color(0xFF27AE60);
        statusIcon = Icons.check_circle_outline_rounded;
        displayStatus = AppString.paid.tr;
        break;
      case 'receiver':
        statusColor = Colors.blue;
        statusIcon = Icons.account_balance_wallet_outlined;
        displayStatus = AppString.beneficiary.tr;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        displayStatus = AppString.pending.tr;
    }

    String formattedDate = AppString.pending.tr;
    if (date != null) {
      formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(date));
    } else if (status.toLowerCase() == 'receiver') {
      formattedDate = AppString.beneficiary.tr;
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
                text: displayStatus.capitalizeFirst ?? '',
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
}
