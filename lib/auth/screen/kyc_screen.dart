import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../component/common_appbar/common_appbar.dart';
import '../controller/kyc_controller.dart';

class KycScreen extends StatelessWidget {
  KycScreen({super.key});

  final KycController controller = Get.put(KycController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildWhyKycCard(),
            SizedBox(height: 24.h),
            CommonText(
              text: "Verification Steps",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),
            
            // Step 1: Government ID
            Obx(() => _buildKycStep(
                  number: "1",
                  title: "Government ID",
                  description: controller.governmentIdPath.isEmpty
                      ? "Upload a valid ID (Passport, Driver's License, etc.)"
                      : "ID Selected: ${controller.governmentIdPath.value.split('/').last}",
                  icon: Icons.description_outlined,
                  isUploaded: controller.governmentIdPath.isNotEmpty,
                  onTap: () => controller.pickDocument(1),
                )),

            // Step 2: Proof of Address
            Obx(() => _buildKycStep(
                  number: "2",
                  title: "Proof of Address",
                  description: controller.proofOfAddressPath.isEmpty
                      ? "Utility bill, bank statement, or lease agreement"
                      : "Document Selected: ${controller.proofOfAddressPath.value.split('/').last}",
                  icon: Icons.description_outlined,
                  isUploaded: controller.proofOfAddressPath.isNotEmpty,
                  onTap: () => controller.pickDocument(2),
                )),

            // Step 3: Selfie Verification
            Obx(() => _buildKycStep(
                  number: "3",
                  title: "Selfie Verification",
                  description: controller.selfiePath.isEmpty
                      ? "Take a selfie holding your ID"
                      : "Selfie captured",
                  icon: Icons.camera_alt_outlined,
                  isUploaded: controller.selfiePath.isNotEmpty,
                  onTap: () => controller.pickDocument(3),
                )),
                
            SizedBox(height: 40.h),
            
            // Bottom Button: Upload All Documents
            Obx(() => CommonButton(
                  titleText: "Upload All Documents",
                  buttonColor: controller.isAllUploaded ? null : Colors.grey.shade300,
                  gradient: controller.isAllUploaded ? AppColors.primaryGradient : null,
                  titleColor: controller.isAllUploaded ? Colors.white : Colors.grey,
                  onTap: controller.isAllUploaded
                      ? () => controller.submitKyc()
                      : null,
                )),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyKycCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
    );
  }

  Widget _buildKycStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
                      color: isUploaded ? Colors.green : AppColors.textSecondaryColor,
                    ),
                  ],
                ),
              ),
              if (isUploaded)
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ],
          ),
          SizedBox(height: 16.h),
          CommonButton(
            titleText: isUploaded ? "Change Document" : "Upload Document",
            buttonHeight: 40,
            buttonRadius: 20,
            buttonColor: Colors.white,
            borderColor: Colors.grey.withOpacity(0.3),
            titleColor: isUploaded ? Colors.green : AppColors.textSecondaryColor,
            titleSize: 14,
            showIcon: !isUploaded,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
