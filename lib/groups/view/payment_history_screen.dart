import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    _buildSummaryCards(),
                    SizedBox(height: 24.h),
                    _buildTransactionList(),
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
          SizedBox(width: 15.w),
          CommonText(
            text: "Payment History",
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            label: "Total Paid",
            amount: "\$1,000",
            backgroundColor: const Color(0xFFE8F9F5),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _buildSummaryCard(
            label: "This Month",
            amount: "\$650",
            backgroundColor: const Color(0xFFF1F8FF),
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

  Widget _buildTransactionList() {
    final transactions = [
      {
        "title": "Family Savings",
        "date": "Jun 7, 2026",
        "amount": "\$200",
        "status": "completed",
        "id": "TXN-2026-0607-001",
        "isCompleted": true,
      },
      {
        "title": "Friends Circle",
        "date": "Jun 5, 2026",
        "amount": "\$150",
        "status": "completed",
        "id": "TXN-2026-0605-002",
        "isCompleted": true,
      },
      {
        "title": "Wedding Fund",
        "date": "Jun 1, 2026",
        "amount": "\$300",
        "status": "completed",
        "id": "TXN-2026-0601-003",
        "isCompleted": false,
      },
      {
        "title": "Family Savings",
        "date": "May 15, 2026",
        "amount": "\$200",
        "status": "completed",
        "id": "TXN-2028-0515-004",
        "isCompleted": true,
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _buildTransactionCard(
          title: tx["title"] as String,
          date: tx["date"] as String,
          amount: tx["amount"] as String,
          status: tx["status"] as String,
          id: tx["id"] as String,
          isCompleted: tx["isCompleted"] as bool,
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
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF2F2F7)),
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
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle_outline : Icons.access_time,
                  size: 20.sp,
                  color: AppColors.black,
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
                      color: AppColors.black,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 12.sp, color: const Color(0xFF828282)),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: date,
                          fontSize: 12.sp,
                          color: const Color(0xFF828282),
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
                    color: AppColors.black,
                  ),
                  CommonText(
                    text: status,
                    fontSize: 12.sp,
                    color: const Color(0xFF27AE60),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFFF2F2F7), thickness: 1),
          SizedBox(height: 8.h),
          CommonText(
            text: "Transaction ID: $id",
            fontSize: 12.sp,
            color: const Color(0xFF828282),
          ),
        ],
      ),
    );
  }
}
