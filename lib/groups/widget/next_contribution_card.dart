import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../config/route/app_routes.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/group_details_controller.dart';
import '../data/group_details_model.dart';

class NextContributionCard extends StatelessWidget {
  final GroupDetailsModel details;

  const NextContributionCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final GroupDetailsController controller = Get.find<GroupDetailsController>();
    
    return Obx(() {
      // Current group state
      final currentPeriod = details.currentPeriod ?? 0;
      final currentCycle = details.currentCycle ?? 0;
      
      // History state currently viewed
      final selectedPeriod = controller.periodHistory.value?.periodNumber ?? 0;
      final selectedCycle = controller.periodHistory.value?.cycleNumber ?? 0;
      
      // Strict match logic: Show if it matches the current active period and cycle
      bool isMatch = (selectedPeriod == currentPeriod) && (selectedCycle == currentCycle);
      
      // Future check
      bool isFuture = (selectedPeriod > currentPeriod) || (selectedPeriod == currentPeriod && selectedCycle > currentCycle);
      
      // Past check
      bool isPast = (selectedPeriod < currentPeriod) || (selectedPeriod == currentPeriod && selectedCycle < currentCycle);

      // Show Pay Now if:
      // 1. Group is active
      // 2. User is not the receiver for this period
      // 3. User hasn't paid yet
      // 4. AND (It is the current period OR It is a past period and user is still pending)
      bool canPay = details.group?.status?.toLowerCase() == "active" && 
                    !controller.isCurrentUserReceiver() && 
                    !controller.isCurrentUserPaid() && 
                    (isMatch || (isPast && controller.isCurrentUserPending())) && 
                    !isFuture;

      if (canPay) {
        return _buildCard(context, controller, isPast);
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildCard(BuildContext context, GroupDetailsController controller, bool isPast) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final group = details.group!;
    final history = controller.periodHistory.value;
    
    final displayCycle = history?.cycleNumber ?? details.currentCycle ?? 1;
    
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
                  color: isPast ? Colors.orange : const Color(0xFF00ADEF),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: isPast ? AppString.pendingContribution.tr : AppString.nextContribution.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isPast ? Colors.orange : (isDark ? Colors.white : Colors.black),
                    ),
                    CommonText(
                      text: AppString.cycleNum.trParams({'num': '$displayCycle'}),
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
              Expanded(
                child: CommonText(
                  text: isPast ? AppString.overdue.tr : "${AppString.due.tr}: $nextDate",
                  fontSize: 14,
                  color: isPast ? Colors.redAccent : (isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.makePayment,
                  arguments: {
                    "id": group.id,
                    "amount": "${group.contributionAmount}",
                    "groupName": group.name ?? "N/A",
                    "dueDate": nextDate,
                    "periodNumber": history?.periodNumber,
                    "cycleNumber": history?.cycleNumber,
                  },
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: isPast ? const LinearGradient(colors: [Colors.orange, Colors.deepOrange]) : AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: (isPast ? Colors.orange : Colors.blue).withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
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
