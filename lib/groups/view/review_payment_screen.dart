import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import 'stripe_web_view_page.dart';

class ReviewPaymentScreen extends StatelessWidget {
  const ReviewPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Map<String, dynamic> args =
        Get.arguments ??
        {
          'amount': '\$200.00',
          'groupName': 'Family Savings',
          'dueDate': 'Jun 15, 2026',
        };
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      CommonText(
                        text: AppString.reviewYourPayment.tr,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: AppString.confirmDetailsBefore.tr,
                        fontSize: 14.sp,
                        color: isDark ? Colors.white70 : AppColors.textSecondaryColor7C7C7C,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      _buildPayingCard(args['amount']),
                      SizedBox(height: 24.h),
                      _buildPaymentDetails(args, isDark),
                      SizedBox(height: 24.h),
                      _buildSummaryCard(args['amount'], isDark),
                      SizedBox(height: 40.h),
                      CommonButton(
                        titleText: AppString.confirmAndPay.tr,
                        buttonHeight: 54.h,
                        buttonRadius: 30,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
                        ),
                        onTap: () {
                          Get.to(() => const StripeWebViewPage(
                                checkoutUrl: 'https://checkout.stripe.com/pay/placeholder_url',
                          ));
                        },
                      ),
                      SizedBox(height: 12.h),
                      CommonButton(
                        titleText: AppString.cancel.tr,
                        titleColor: const Color(0xFF828282),
                        buttonColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
                        borderColor: isDark ? AppColors.darkCardBorder : const Color(0xFFD1D1D6),
                        buttonHeight: 54.h,
                        buttonRadius: 30,
                        onTap: () => Get.back(),
                      ),
                      SizedBox(height: 24.h),
                      CommonText(
                        text: AppString.byConfirmingAgree.tr,
                        fontSize: 12.sp,
                        color: isDark ? Colors.white38 : const Color(0xFF828282),
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
            text: AppString.youArePaying.tr,
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
          const CommonText(
            text: "USD",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(Map<String, dynamic> args, bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : null,
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.paymentDetails.tr,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 20.h),
          _buildDetailItem(Icons.people_outline, AppString.group.tr, args['groupName']),
          SizedBox(height: 16.h),
          _buildDetailItem(Icons.attach_money, AppString.paymentAmount.tr, args['amount']),
          SizedBox(height: 16.h),
          _buildDetailItem(
            Icons.calendar_today_outlined,
            "${AppString.due.tr} ${AppString.date.tr}",
            args['dueDate'],
          ),
          if (args['periodNumber'] != null) ...[
            SizedBox(height: 16.h),
            _buildDetailItem(
              Icons.info_outline,
              AppString.period.tr,
              "${args['periodNumber']}",
            ),
          ],
          if (args['cycleNumber'] != null) ...[
            SizedBox(height: 16.h),
            _buildDetailItem(
              Icons.loop,
              AppString.cycle.tr,
              "${args['cycleNumber']}",
            ),
          ],
          SizedBox(height: 16.h),
          _buildDetailItem(
            Icons.credit_card_outlined,
            AppString.paymentMethod.tr,
            AppString.cardEnding.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    final isDark = Get.isDarkMode;
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
              color: isDark ? Colors.white38 : const Color(0xFF828282),
            ),
            SizedBox(height: 2.h),
            CommonText(
              text: value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String amount, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
      ),
      child: Column(
        children: [
          _buildSummaryRow(AppString.contribution.tr, amount),
          SizedBox(height: 12.h),
          _buildSummaryRow(AppString.processingFee.tr, "\$0.00"),
          Divider(height: 32.h, color: isDark ? Colors.white10 : const Color(0xFFE0E0E0)),
          _buildSummaryRow(AppString.total.tr, amount, isTotal: true),
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
        ),
        CommonText(
          text: value,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
        ),
      ],
    );
  }
}
