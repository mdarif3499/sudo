import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';

class ReviewPaymentScreen extends StatelessWidget {
  const ReviewPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        Get.arguments ??
        {
          'amount': '\$200.00',
          'groupName': 'Family Savings',
          'dueDate': 'Jun 15, 2026',
        };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    CommonText(
                      text: "Review Your Payment",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF242424),
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text:
                          "Please confirm the details below before\nproceeding",
                      fontSize: 14.sp,
                      color: AppColors.textSecondaryColor7C7C7C,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    _buildPayingCard(args['amount']),
                    SizedBox(height: 24.h),
                    _buildPaymentDetails(args),
                    SizedBox(height: 24.h),
                    _buildSummaryCard(args['amount']),
                    SizedBox(height: 40.h),
                    CommonButton(
                      titleText: "Confirm & Pay",
                      buttonHeight: 54.h,
                      buttonRadius: 30,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
                      ),
                      onTap: () {
                        // Handle payment confirmation
                      },
                    ),
                    SizedBox(height: 12.h),
                    CommonButton(
                      titleText: "Cancel",
                      titleColor: const Color(0xFF828282),
                      buttonColor: Colors.white,
                      borderColor: const Color(0xFFD1D1D6),
                      buttonHeight: 54.h,
                      buttonRadius: 30,
                      onTap: () => Get.back(),
                    ),
                    SizedBox(height: 24.h),
                    CommonText(
                      text:
                          "By confirming, you agree to our payment terms and conditions",
                      fontSize: 12.sp,
                      color: const Color(0xFF828282),
                      textAlign: TextAlign.center,
                    ),
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

  Widget _buildAppBar() {
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
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayingCard(String amount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B44D1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CommonText(
            text: "You're Paying",
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: amount,
            fontSize: 44,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          CommonText(
            text: "USD",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(Map<String, dynamic> args) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Payment Details",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF242424),
          ),
          SizedBox(height: 20.h),
          _buildDetailItem(Icons.people_outline, "Group", args['groupName']),
          SizedBox(height: 16.h),
          _buildDetailItem(Icons.attach_money, "Amount", args['amount']),
          SizedBox(height: 16.h),
          _buildDetailItem(
            Icons.calendar_today_outlined,
            "Due Date",
            args['dueDate'],
          ),
          SizedBox(height: 16.h),
          _buildDetailItem(
            Icons.credit_card_outlined,
            "Payment Method",
            "Card ending •••• 4242",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF00ADEF), size: 20.sp),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: label,
              fontSize: 12.sp,
              color: const Color(0xFF828282),
            ),
            SizedBox(height: 2.h),
            CommonText(
              text: value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF242424),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String amount) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF2F2F7)),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Contribution", amount),
          SizedBox(height: 12.h),
          _buildSummaryRow("Processing Fee", "\$0.00"),
          Divider(height: 32.h, color: const Color(0xFFE0E0E0)),
          _buildSummaryRow("Total", amount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: label,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          color: const Color(0xFF242424),
        ),
        CommonText(
          text: value,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          color: const Color(0xFF242424),
        ),
      ],
    );
  }
}
