import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/payment_history_controller.dart';
import '../data/payment_history_model.dart';
import '../../component/other_widgets/common_skeleton.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentHistoryController());
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
              _buildAppBar(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.historyList.isEmpty) {
                    return _buildSkeleton();
                  }

                  return RefreshIndicator(
                    onRefresh: () => controller.fetchPaymentHistory(),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          _buildSummaryCards(controller, isDark),
                          SizedBox(height: 24.h),
                          if (controller.historyList.isEmpty)
                            _buildEmptyState()
                          else
                            _buildTransactionList(controller, isDark),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Icon(Icons.history, size: 64.sp, color: Colors.grey.shade300),
        SizedBox(height: 16.h),
        CommonText(
          text: AppString.noPaymentHistoryFound.tr,
          color: Colors.grey,
          fontSize: 16,
        ),
      ],
    );
  }

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: CommonSkeleton(height: 100.h, width: double.infinity, borderRadius: 12)),
              SizedBox(width: 15.w),
              Expanded(child: CommonSkeleton(height: 100.h, width: double.infinity, borderRadius: 12)),
            ],
          ),
          SizedBox(height: 24.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) => CommonSkeleton(height: 120.h, width: double.infinity, borderRadius: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    final isDark = Get.isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? Colors.white24 : const Color(0xFFE0E0E0)),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: isDark ? Colors.white : AppColors.black,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          CommonText(
            text: AppString.paymentHistory.tr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(PaymentHistoryController controller, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            label: AppString.totalPaid.tr,
            amount: "\$${controller.totalPaid.value.toStringAsFixed(0)}",
            backgroundColor: isDark ? AppColors.darkCardBg : const Color(0xFFE8F9F5),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _buildSummaryCard(
            label: AppString.thisMonth.tr,
            amount: "\$${controller.thisMonthPaid.value.toStringAsFixed(0)}",
            backgroundColor: isDark ? AppColors.darkCardBg : const Color(0xFFF1F8FF),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String label,
    required String amount,
    required Color backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CommonText(
            text: label,
            fontSize: 14.sp,
            color: const Color(0xFF828282),
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: amount,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(PaymentHistoryController controller, bool isDark) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.historyList.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final tx = controller.historyList[index];
        String dateStr = "N/A";
        if (tx.paymentDate != null) {
          dateStr = DateFormat('MMM d, yyyy').format(DateTime.parse(tx.paymentDate!).toLocal());
        }
        
        return _buildTransactionCard(
          title: tx.group?.name ?? "Unknown Group",
          date: dateStr,
          amount: "\$${tx.amount ?? 0}",
          status: tx.status ?? "N/A",
          id: tx.transactionId ?? "N/A",
          isCompleted: tx.status?.toLowerCase() == 'paid',
          isDark: isDark,
        );
      },
    );
  }

  Widget _buildTransactionCard({
    required String title,
    required String date,
    required String amount,
    required String status,
    required String id,
    required bool isCompleted,
    required bool isDark,
  }) {
    String displayStatus = status;
    if (status.toLowerCase() == 'paid') {
      displayStatus = AppString.paid.tr;
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE0E0E0)),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle_outline : Icons.access_time,
                  size: 20.sp,
                  color: isCompleted ? const Color(0xFF27AE60) : Colors.orange,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 12.sp, color: isDark ? Colors.white38 : const Color(0xFF828282)),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: date,
                          fontSize: 12.sp,
                          color: isDark ? Colors.white38 : const Color(0xFF828282),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    text: amount,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CommonText(
                    text: displayStatus.capitalizeFirst ?? '',
                    fontSize: 12.sp,
                    color: isCompleted ? const Color(0xFF27AE60) : Colors.orange,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: isDark ? Colors.white10 : const Color(0xFFF2F2F7), thickness: 1),
          SizedBox(height: 8.h),
          CommonText(
            text: "${AppString.transactionId.tr}: $id",
            fontSize: 12.sp,
            color: isDark ? Colors.white38 : const Color(0xFF828282),
          ),
        ],
      ),
    );
  }
}
