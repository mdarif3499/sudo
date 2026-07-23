import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/utils/constants/app_icons.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/invite_controller.dart';

class InviteMembersScreen extends StatelessWidget {
  InviteMembersScreen({super.key});

  final InviteController controller = Get.put(InviteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(),
        // child: Column(
        //   children: [
        //     _buildAppBar(),
        //     Expanded(
        //       child: SingleChildScrollView(
        //         padding: EdgeInsets.symmetric(horizontal: 24.w),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(height: 10.h),
        //             CommonText(
        //               text: "Grow Your Circle",
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold,
        //               color: AppColors.primaryColor,
        //             ),
        //             SizedBox(height: 8.h),
        //             CommonText(
        //               text:
        //                   "Invite friends and family to join your savings group",
        //               fontSize: 14.sp,
        //               fontWeight: FontWeight.w400,
        //               color: AppColors.textSecondaryColor7C7C7C,
        //             ),
        //             SizedBox(height: 20.h),
        //             _buildShareLinkCard(),
        //             SizedBox(height: 10.h),
        //             _buildDivider(),
        //             SizedBox(height: 10.h),
        //             _buildEmailInviteCard(),
        //             SizedBox(height: 30.h),
        //             CommonText(
        //               text: "Pending Invitations",
        //               fontSize: 18.sp,
        //               fontWeight: FontWeight.w600,
        //               color: const Color(0xFF4F4F4F),
        //             ),
        //             SizedBox(height: 16.h),
        //             _buildPendingInvitationsList(),
        //             SizedBox(height: 20.h),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  // Widget _buildAppBar() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  //     child: Row(
  //       children: [
  //         GestureDetector(
  //           onTap: () => Get.back(),
  //           child: Container(
  //             padding: EdgeInsets.all(10.r),
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               border: Border.all(color: const Color(0xFFE0E0E0)),
  //             ),
  //             child: Icon(
  //               Icons.arrow_back,
  //               size: 20.sp,
  //               color: AppColors.black,
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 15.w),
  //         CommonText(
  //           text: "Invite Members",
  //           fontSize: 20.sp,
  //           fontWeight: FontWeight.w600,
  //           color: AppColors.black,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildShareLinkCard() {
  //   return Container(
  //     padding: EdgeInsets.all(20.r),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16.r),
  //       border: Border.all(color: const Color(0xFFF2F2F7)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withValues(alpha: 0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(12.r),
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFEBF8FF),
  //                 borderRadius: BorderRadius.circular(12.r),
  //               ),
  //               child: Image.asset(AppIcons.link, height: 24.sp),
  //             ),
  //             SizedBox(width: 16.w),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CommonText(
  //                     text: "Share Invite Link",
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                   CommonText(
  //                     text: "Anyone with this link can join",
  //                     fontSize: 12.sp,
  //                     color: AppColors.textSecondaryColor7C7C7C,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 20.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: 16.w,
  //                   vertical: 12.h,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFFf1fbff),
  //                   border: Border.all(color: const Color(0xFFd6f3fe)),
  //                   borderRadius: BorderRadius.circular(12.r),
  //                 ),
  //                 child: CommonText(
  //                   text: controller.inviteLink,
  //                   fontSize: 14.sp,
  //                   color: const Color(0xFF828282),
  //                   maxLines: 1,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 12.w),
  //             CommonButton(
  //               titleText: "Copy",
  //               buttonWidth: 100.w,
  //               buttonHeight: 48.h,
  //               buttonRadius: 12,
  //               prefixIcon: Icon(Icons.copy, color: Colors.white, size: 18.sp),
  //               gradient: const LinearGradient(
  //                 colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
  //               ),
  //               onTap: () => controller.copyInviteLink(),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildDivider() {
  //   return Row(
  //     children: [
  //       const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16.w),
  //         child: CommonText(
  //           text: "OR",
  //           fontSize: 12.sp,
  //           color: const Color(0xFFBDBDBD),
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
  //     ],
  //   );
  // }
  //
  // Widget _buildEmailInviteCard() {
  //   return Container(
  //     padding: EdgeInsets.all(20.r),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16.r),
  //       border: Border.all(color: const Color(0xFFF2F2F7)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withValues(alpha: 0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Icon(Icons.email_outlined, color: AppColors.black, size: 24.sp),
  //             SizedBox(width: 16.w),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CommonText(
  //                     text: "Send Email Invite",
  //                     fontSize: 18.sp,
  //                     color: AppColors.primaryColor,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                   CommonText(
  //                     text: "Enter email to send invitation",
  //                     fontSize: 12.sp,
  //                     fontWeight: FontWeight.w400,
  //                     color: AppColors.textSecondaryColor7C7C7C,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 20.h),
  //         TextField(
  //           controller: controller.emailController,
  //           decoration: InputDecoration(
  //             hintText: "friend@example.com",
  //             hintStyle: TextStyle(
  //               color: const Color(0xFFBDBDBD),
  //               fontSize: 14.sp,
  //             ),
  //             filled: true,
  //             fillColor: const Color(0xFF48C8FC).withValues(alpha: 0.08),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(22.r),
  //               borderSide: BorderSide(
  //                 color: const Color(0xFF48C8FC).withValues(alpha: 0.16),
  //                 width: 1,
  //               ),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(22.r),
  //               borderSide: BorderSide(
  //                 color: const Color(0xFF48C8FC).withValues(alpha: 0.16),
  //                 width: 1,
  //               ),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(22.r),
  //               borderSide: BorderSide(
  //                 color: const Color(0xFF48C8FC).withValues(alpha: 0.16),
  //                 width: 1,
  //               ),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(
  //               horizontal: 16.w,
  //               vertical: 16.h,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 20.h),
  //         CommonButton(
  //           titleText: "Send Invitation",
  //           buttonHeight: 52.h,
  //           buttonRadius: 12,
  //           gradient: const LinearGradient(
  //             colors: [Color(0xFF00ADEF), Color(0xFF3B44D1)],
  //           ),
  //           onTap: () => controller.sendInvitation(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPendingInvitationsList() {
    return Obx(
      () => Column(
        children: controller.pendingInvites.map((invite) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildPendingItem(invite.email, invite.time),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPendingItem(String email, String time) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF2F2F7)),
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
                  color: const Color(0xFF828282),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => controller.resendInvitation(email),
            child: CommonText(
              text: "Resend",
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
