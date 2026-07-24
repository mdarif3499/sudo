import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/utils/constants/app_icons.dart';
import 'package:sudo/utils/constants/app_string.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/invite_controller.dart';

class InviteMembersScreen extends StatelessWidget {
  InviteMembersScreen({super.key});

  final InviteController controller = Get.put(InviteController());

  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      CommonText(
                        text: AppString.growYourCircle.tr,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.primaryColor,
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: AppString.inviteDescription.tr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.white70 : AppColors.textSecondaryColor7C7C7C,
                      ),
                      SizedBox(height: 20.h),
                      _buildShareLinkCard(isDark),
                      SizedBox(height: 10.h),
                      _buildDivider(),
                      SizedBox(height: 10.h),
                      _buildEmailInviteCard(isDark),
                      SizedBox(height: 30.h),
                      CommonText(
                        text: AppString.pendingInvitations.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
                      ),
                      SizedBox(height: 16.h),
                      _buildPendingInvitationsList(isDark),
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
          SizedBox(width: 15.w),
          CommonText(
            text: AppString.inviteMember.tr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildShareLinkCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF8FF).withValues(alpha: isDark ? 0.1 : 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Image.asset(AppIcons.link, height: 24.sp, color: const Color(0xFF00ADEF)),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.shareInviteLink.tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    CommonText(
                      text: AppString.anyoneWithLink.tr,
                      fontSize: 12.sp,
                      color: isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFf1fbff),
                    border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFd6f3fe)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CommonText(
                    text: controller.inviteLink,
                    fontSize: 14.sp,
                    color: isDark ? Colors.white70 : const Color(0xFF828282),
                    maxLines: 1,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              CommonButton(
                titleText: AppString.copy.tr,
                buttonWidth: 100.w,
                buttonHeight: 48.h,
                buttonRadius: 12,
                prefixIcon: Icon(Icons.copy, color: Colors.white, size: 18.sp),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
                ),
                onTap: () => controller.copyInviteLink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CommonText(
            text: AppString.or.tr,
            fontSize: 12.sp,
            color: const Color(0xFFBDBDBD),
            fontWeight: FontWeight.w600,
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
      ],
    );
  }

  Widget _buildEmailInviteCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.email_outlined, color: isDark ? Colors.white70 : AppColors.black, size: 24.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.sendEmailInvite.tr,
                      fontSize: 18.sp,
                      color: isDark ? Colors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    CommonText(
                      text: AppString.enterEmailToInvite.tr,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white60 : AppColors.textSecondaryColor7C7C7C,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: controller.emailController,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "friend@example.com",
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : const Color(0xFFBDBDBD),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFF48C8FC).withValues(alpha: 0.08),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkCardBorder : const Color(0xFF48C8FC).withValues(alpha: 0.16),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkCardBorder : const Color(0xFF48C8FC).withValues(alpha: 0.16),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(
                  color: AppColors.indicatorActive,
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          CommonButton(
            titleText: AppString.sendInvitation.tr,
            buttonHeight: 52.h,
            buttonRadius: 12,
            gradient: const LinearGradient(
              colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
            ),
            onTap: () => controller.sendInvitation(""), // Need groupId here if calling from this screen
          ),
        ],
      ),
    );
  }

  Widget _buildPendingInvitationsList(bool isDark) {
    return Obx(
      () => Column(
        children: controller.pendingInvites.map((invite) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildPendingItem(invite.email, invite.time, isDark),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPendingItem(String email, String time, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : const Color(0xFFF2F2F7)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: email,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: time,
                  fontSize: 12.sp,
                  color: isDark ? Colors.white38 : const Color(0xFF828282),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => controller.resendInvitation(email),
            child: CommonText(
              text: AppString.resend.tr,
              fontSize: 14.sp,
              color: const Color(0xFF2F80ED),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
