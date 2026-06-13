import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/payment_method_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Payment Methods"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            // Add Payment Method Button
            GestureDetector(
              onTap: () => controller.addPaymentMethod(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8.w),
                    CommonText(
                      text: "Add Payment Method",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
            // Payment Methods List
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: controller.paymentMethods.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final method = controller.paymentMethods[index];
                  return _buildPaymentMethodItem(method);
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    bool isCard = method['type'] == 'card';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
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
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isCard ? Icons.credit_card_outlined : Icons.account_balance_outlined,
              color: const Color(0xFF4A7FE0),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: isCard 
                      ? "${method['brand']} ending in ${method['last4']}"
                      : method['name'],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: isCard 
                      ? "Expires ${method['expiry']}"
                      : "Account •••• ${method['last4']}",
                  fontSize: 13,
                  color: AppColors.textSecondaryColor,
                ),
                if (method['isDefault'] == true) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A7FE0).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CommonText(
                      text: "Default",
                      fontSize: 11,
                      color: const Color(0xFF4A7FE0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
