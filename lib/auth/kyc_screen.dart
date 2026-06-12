import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../component/common_appbar/common_appbar.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: AppColors.buttonGradientEnd),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Why KYC?",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          text:
                              "KYC verification ensures a secure and trustworthy community. It helps prevent fraud and protects all members.",
                          fontSize: 12,
                          color: AppColors.textSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CommonText(
              text: "Verification Steps",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),
            _buildKycStep(
              number: "1",
              title: "Government ID",
              description: "Upload a valid ID (Passport, Driver's License, etc.)",
              icon: Icons.description_outlined,
            ),
            _buildKycStep(
              number: "2",
              title: "Proof of Address",
              description: "Utility bill, bank statement, or lease agreement",
              icon: Icons.description_outlined,
            ),
            _buildKycStep(
              number: "3",
              title: "Selfie Verification",
              description: "Take a selfie holding your ID",
              icon: Icons.file_upload_outlined,
            ),
            SizedBox(height: 40.h),
            CommonButton(
              titleText: "Upload All Documents",
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFB2EBF2),
                  const Color(0xFFC5CAE9),
                ],
              ),
              titleColor: AppColors.buttonGradientEnd,
              onTap: () {
                // Handle upload
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildKycStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColors.buttonGradientEnd, size: 24),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "$number. $title",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: description,
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CommonButton(
            titleText: "Upload Document",
            buttonHeight: 40,
            buttonRadius: 20,
            buttonColor: Colors.white,
            borderColor: Colors.grey.withValues(alpha: 0.3),
            titleColor: AppColors.textSecondaryColor,
            titleSize: 14,
            showIcon: true,
            iconPath: null, // Default arrow or upload icon
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
