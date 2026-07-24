import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/route/app_routes.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../component/text_field/common_text_field.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../controller/group_details_controller.dart';
import '../controller/invite_controller.dart';

class GroupActionButtons extends StatelessWidget {
  const GroupActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupDetailsController controller = Get.find<GroupDetailsController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Obx(() {
      final group = controller.groupDetails.value?.group;
      if (group == null) return const SizedBox.shrink();
      
      final status = group.status?.toLowerCase() ?? "";
      final isAdmin = controller.isUserAdmin();
      final bool isFull = (group.members?.length ?? 0) >= (group.targetedMembers ?? 0);

      return Row(
        children: [
          if (status == "pending") ...[
            if (isFull && isAdmin)
              Expanded(
                child: CommonButton(
                  titleText: AppString.startGroup.tr,
                  buttonHeight: 52.h,
                  buttonRadius: 14,
                  isLoading: controller.isStarting.value,
                  gradient: AppColors.primaryGradient,
                  prefixIcon:  Icon(Icons.play_arrow_outlined, color: Colors.white, size: 20.sp),
                  onTap: () => controller.startGroup(group.id!),
                ),
              )
            else if (!isFull)
              Expanded(
                child: CommonButton(
                  titleText: AppString.invite.tr,
                  buttonHeight: 52.h,
                  buttonRadius: 14,
                  gradient: AppColors.primaryGradient,
                  prefixIcon:  Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 20.sp),
                  onTap: () => _showInviteDialog(context, group.id!),
                ),
              ),
            
            if ((isFull && isAdmin) || !isFull) SizedBox(width: 15.w),
          ],

          Expanded(
            child: CommonButton(
              titleText: AppString.chat.tr,
              titleColor: isDark ? Colors.white : AppColors.black,
              buttonColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
              borderColor: isDark ? AppColors.darkCardBorder : const Color(0xFFE0E0E0),
              buttonHeight: 52.h,
              buttonRadius: 14,
              prefixIcon: Icon(
                Icons.chat_bubble_outline,
                color: isDark ? Colors.white : AppColors.black,
                size: 20.sp,
              ),
              onTap: () => Get.toNamed(
                AppRoutes.chat,
                arguments: {
                  "id": group.id,
                  "name": group.name,
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showInviteDialog(BuildContext context, String groupId) {
    final inviteController = Get.put(InviteController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        backgroundColor: isDark ? AppColors.darkCardBg : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: AppString.inviteMember.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: isDark ? Colors.white70 : Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CommonText(
                text: AppString.sendInvitationEmail.tr,
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey,
              ),
              SizedBox(height: 24.h),
              CommonTextField(
                controller: inviteController.emailController,
                hintText: AppString.emailHint.tr,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
                borderRadius: 16,
              ),
              SizedBox(height: 32.h),
              Obx(() => CommonButton(
                titleText: AppString.sendInvitation.tr,
                isLoading: inviteController.isLoading.value,
                gradient: AppColors.primaryGradient,
                buttonRadius: 14,
                onTap: () => inviteController.sendInvitation(groupId),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
