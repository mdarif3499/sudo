import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../config/route/app_routes.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Getting arguments if passed, otherwise using default values
    final Map<String, dynamic> args =
        Get.arguments ??
        {
          'amount': '\$200.00',
          'groupName': 'Family Savings',
          'dueDate': 'Jun 15, 2026',
        };

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _buildPaymentCard(args),
                    SizedBox(height: 30.h),
                    CommonText(
                      text: "Select Payment Method",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
                    ),
                    SizedBox(height: 16.h),
                    _buildPaymentOption(
                      context,
                      icon: Icons.credit_card_outlined,
                      title: "Stripe",
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.reviewPayment,
                          arguments: args,
                        );
                      },
                    ),
                    SizedBox(height: 100.h), // Spacer
                  ],
                ),
              ),
            ),
            _buildBottomButton(context),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            text: "Make Payment",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> args) {
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
            text: "Payment Amount",
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: args['amount'],
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                _buildCardRow("To:", args['groupName']),
                SizedBox(height: 8.h),
                _buildCardRow("Due Date:", args['dueDate']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: label,
          fontSize: 14,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        CommonText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBg : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F8FF),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF3B44D1),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white38 : Colors.grey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CommonButton(
        titleText: "View Payment History",
        titleColor: isDark ? Colors.white70 : const Color(0xFF828282),
        buttonColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderColor: isDark ? AppColors.darkCardBorder : const Color(0xFFD1D1D6),
        buttonHeight: 54.h,
        buttonRadius: 30,
        onTap: () {
          Get.toNamed(AppRoutes.paymentHistory);
        },
      ),
    );
  }
}
