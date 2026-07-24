import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_string.dart';
import '../controller/profile_controller.dart';
import '../../services/localization/language_controller.dart';
import '../widget/profile_menu_item.dart';
import '../../component/other_widgets/common_skeleton.dart';
import '../../component/image/common_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final LanguageController langController = Get.find<LanguageController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      body: Container(
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
          child: Obx(() {
            if (controller.isLoading.value) {
              return _buildSkeleton(context);
            }

            final data = controller.profileData.value;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: AppString.profile.tr,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      // Image.asset(
                      //   AppIcons.notification,
                      //   height: 42.h,
                      //   width: 42.w,
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CommonText(
                      text: AppString.accountSettings.tr,
                      fontSize: 14,
                      color: isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1),
                      ),
                      boxShadow: isDark ? [] : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: data?['image'] == null ? AppColors.primaryGradient : null,
                          ),
                          child: data?['image'] != null
                              ? CommonImage(
                                  imageSrc: data!['image'],
                                  borderRadius: 40,
                                  height: 80,
                                  width: 80,
                                  fill: BoxFit.cover,
                                )
                              : Center(
                                  child: CommonText(
                                    text: (data?['fullName'] ?? "U").substring(0, 1).toUpperCase(),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        SizedBox(height: 12.h),
                        CommonText(
                          text: data?['fullName'] ?? "User",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          text: data?['email'] ?? "",
                          fontSize: 14,
                          color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.editProfile, arguments: data),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppIcons.edit,
                                  color: Colors.white,
                                  height: 18.h,
                                  width: 18.w,
                                ),
                                SizedBox(width: 8.w),
                                CommonText(
                                  text: AppString.editProfile.tr,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Stats Row
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context, 
                            controller.dashboardData.value?.activeGroups?.toString() ?? "0", 
                            AppString.activeGroups.tr
                          )
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildStatCard(
                            context, 
                            _formatAmount(controller.dashboardData.value?.totalSavings), 
                            AppString.totalSaved.tr
                          )
                        ),
                      ],
                    ),
                  ),
                  _buildSectionTitle(context, AppString.account.tr),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildProfileMenu(
                          icon: AppIcons.profile,
                          iconColor: Colors.blue,
                          iconBgColor: Colors.blue.withValues(alpha: 0.1),
                          title: AppString.editProfile.tr,
                          onTap: () => Get.toNamed(AppRoutes.editProfile, arguments: data),
                        ),
                        SizedBox(height: 5.h),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
                        _buildProfileMenu(
                          icon: AppIcons.kyc,
                          iconColor: Colors.green,
                          iconBgColor: Colors.green.withValues(alpha: 0.1),
                          title: AppString.kycVerification.tr,
                          trailingText: data?['kycStatus']?.toString().capitalizeFirst ?? "Required",
                          trailingTextColor: data?['kycStatus'] == 'approved' ? Colors.green : Colors.orange,
                          onTap: () {},
                        ),
                        SizedBox(height: 5.h),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
                        _buildProfileMenu(
                          icon: AppIcons.subscriptions,
                          iconColor: Colors.orange,
                          iconBgColor: Colors.orange.withValues(alpha: 0.1),
                          title: AppString.subscriptions.tr,
                          trailingText: AppString.free.tr,
                          trailingTextColor: Colors.orange,
                          onTap: () {
                            Get.toNamed(AppRoutes.subscriptionScreen);
                          },
                        ),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
                        Obx(() => _buildProfileMenu(
                          icon: Icons.language,
                          iconColor: Colors.purple,
                          iconBgColor: Colors.purple.withValues(alpha: 0.1),
                          title: AppString.language.tr,
                          trailingText: langController.selectedLanguage.value,
                          onTap: () => Get.toNamed(AppRoutes.language),
                        )),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionTitle(context, AppString.support.tr),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildProfileMenu(
                          icon: AppIcons.faqs,
                          iconColor: const Color(0xFF4A7FE0),
                          iconBgColor: const Color(0xFF4A7FE0).withValues(alpha: 0.1),
                          title: AppString.faqsTitle.tr,
                          onTap: () => Get.toNamed(AppRoutes.faq),
                        ),
                        SizedBox(height: 5.h),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
                        _buildProfileMenu(
                          icon: AppIcons.privacy,
                          iconColor: const Color(0xFF10B981),
                          iconBgColor: const Color(0xFF10B981).withValues(alpha: 0.1),
                          title: AppString.privacyPolicyTitle.tr,
                          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                        ),
                        SizedBox(height: 5.h),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E4ED)),
                        _buildProfileMenu(
                          icon: AppIcons.terms,
                          iconColor: const Color(0xFF8B5CF6),
                          iconBgColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                          title: AppString.termsConditionTitle.tr,
                          onTap: () => Get.toNamed(AppRoutes.termsCondition),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  GestureDetector(
                    onTap: () {
                      controller.logOut();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.red, size: 20.sp),
                          SizedBox(width: 8.w),
                          CommonText(
                            text: AppString.logout.tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonSkeleton(height: 32.h, width: 100.w),
              CommonSkeleton(height: 42.r, width: 42.r, borderRadius: 21),
            ],
          ),
          SizedBox(height: 40.h),
          CommonSkeleton(height: 200.h, width: double.infinity, borderRadius: 20),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16)),
              SizedBox(width: 16.w),
              Expanded(child: CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16)),
            ],
          ),
          SizedBox(height: 24.h),
          CommonSkeleton(height: 20.h, width: 100.w),
          SizedBox(height: 12.h),
          CommonSkeleton(height: 250.h, width: double.infinity, borderRadius: 16),
          SizedBox(height: 24.h),
          CommonSkeleton(height: 250.h, width: double.infinity, borderRadius: 16),
        ],
      ),
    );
  }

  Widget _buildProfileMenu({
    required dynamic icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? trailingText,
    Color? trailingTextColor,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ProfileMenuItem(
      icon: icon,
      iconColor: iconColor,
      iconBgColor: iconBgColor,
      title: title,
      trailingText: trailingText,
      trailingTextColor: trailingTextColor,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isDark ? AppColors.darkCardBorder : Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          CommonText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: label,
            fontSize: 12,
            textAlign: TextAlign.center,
            color: isDark ? Colors.white60 : AppColors.textSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CommonText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white : AppColors.textPrimary,
    );
  }

  String _formatAmount(num? amount) {
    if (amount == null) return "\$0";
    if (amount >= 1000) {
      double kAmount = amount / 1000;
      if (kAmount == kAmount.toInt()) {
        return "\$${kAmount.toInt()}k";
      }
      return "\$${kAmount.toStringAsFixed(1)}k";
    }
    return "\$${amount.toString()}";
  }
}
