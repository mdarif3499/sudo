import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/image/common_image.dart';
import '../../component/text/common_text.dart';
import '../../component/button/common_button.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/invitation_controller.dart';
import '../data/group_invitation_model.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvitationController());
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
              _buildAppBar(context, isDark),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.invitations.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline, size: 64.sp, color: Colors.grey),
                          SizedBox(height: 16.h),
                          CommonText(text: AppString.noInvitationsFound.tr, fontSize: 16, color: Colors.grey),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => controller.fetchInvitations(),
                    child: ListView.builder(
                      padding: EdgeInsets.all(20.r),
                      itemCount: controller.invitations.length,
                      itemBuilder: (context, index) {
                        return _buildInvitationCard(context, controller.invitations[index], controller);
                      },
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

  Widget _buildAppBar(BuildContext context, bool isDark) {
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
          Expanded(
            child: CommonText(
              text: AppString.groupInvitations.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationCard(BuildContext context, GroupInvitationModel invitation, InvitationController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final group = invitation.group;
    final sender = invitation.sender;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isDark ? Border.all(color: AppColors.darkCardBorder) : Border.all(color: const Color(0xFFF2F2F7)),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48.r,
                width: 48.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: sender?.image == null ? AppColors.primaryGradient : null,
                ),
                child: sender?.image != null
                    ? CommonImage(
                        imageSrc: sender!.image!,
                        borderRadius: 24,
                        height: 48,
                        width: 48,
                        fill: BoxFit.cover,
                      )
                    : Center(
                        child: CommonText(
                          text: (sender?.fullName ?? "S").substring(0, 1).toUpperCase(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: sender?.fullName ?? "Unknown Sender",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CommonText(
                      text: AppString.invitedYouToJoin.tr,
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.grey,
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(invitation.status),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: group?.name ?? "Group Name",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00ADEF),
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(Icons.attach_money, AppString.contribution.tr, "\$${group?.contributionAmount ?? 0}"),
                SizedBox(height: 8.h),
                _buildInfoRow(Icons.calendar_today, AppString.frequency.tr, group?.paymentFrequency?.capitalizeFirst ?? "N/A"),
                SizedBox(height: 8.h),
                _buildInfoRow(Icons.loop, AppString.totalCyclesLabel.tr, "${group?.totalCycles ?? 0}"),
              ],
            ),
          ),
          if (invitation.status == 'pending') ...[
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: Obx(() => CommonButton(
                    titleText: AppString.reject.tr,
                    buttonHeight: 45.h,
                    buttonColor: Colors.transparent,
                    borderColor: Colors.red.withValues(alpha: 0.5),
                    titleColor: Colors.red,
                    isLoading: controller.isActionLoading.value,
                    onTap: () => controller.respondToInvitation(invitation.id!, false),
                  )),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(() => CommonButton(
                    titleText: AppString.accept.tr,
                    buttonHeight: 45.h,
                    gradient: AppColors.primaryGradient,
                    isLoading: controller.isActionLoading.value,
                    onTap: () => controller.respondToInvitation(invitation.id!, true),
                  )),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    Color color;
    switch (status) {
      case 'accepted':
        color = Colors.green;
        break;
      case 'declined':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: CommonText(
        text: status?.capitalizeFirst ?? "Pending",
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 8.w),
        CommonText(text: label, fontSize: 13, color: Colors.grey),
        const Spacer(),
        CommonText(text: value, fontSize: 13, fontWeight: FontWeight.w500),
      ],
    );
  }
}
