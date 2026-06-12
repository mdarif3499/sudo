import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../controller/profile_controller.dart';
import '../widget/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFFFDF8), // Top Right
              Color(0xFFF2FDFB), // Top Left
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.2, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: "Profile",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    Image.asset(AppIcons.notification,
                        height: 42.h, width: 42.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CommonText(
                    text: "Search your saving groups",
                    fontSize: 14,
                    color: AppColors.textSecondaryColor7C7C7C,
                  ),
                ),
                SizedBox(height: 20.h),
                // Profile Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                    boxShadow: [
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                        ),
                        child: Center(
                          child: CommonText(
                            text: "JD",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CommonText(
                        text: "John Doe",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: "john.doe@example.com",
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AppIcons.edit,
                                color: Colors.white, height: 18.h, width: 18.w),
                            SizedBox(width: 8.w),
                            CommonText(
                              text: "Edit Profile",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("4", "Active Groups"),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildStatCard("\$12.5k", "Total Saved"),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildSectionTitle("Account"),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      _buildProfileMenu(
                        icon: AppIcons.profile,
                        iconColor: Colors.blue,
                        iconBgColor: Colors.blue.withValues(alpha: 0.1),
                        title: "Edit Profile",
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _buildProfileMenu(
                        icon: AppIcons.kyc,
                        iconColor: Colors.green,
                        iconBgColor: Colors.green.withValues(alpha: 0.1),
                        title: "KYC Verification",
                        trailingText: "Required",
                        trailingTextColor: Colors.orange,
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _buildProfileMenu(
                        icon: AppIcons.subscriptions,
                        iconColor: Colors.orange,
                        iconBgColor: Colors.orange.withValues(alpha: 0.1),
                        title: "Subscriptions",
                        trailingText: "Free",
                        trailingTextColor: Colors.orange,
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _buildProfileMenu(
                        icon: AppIcons.payment,
                        iconColor: Colors.purple,
                        iconBgColor: Colors.purple.withValues(alpha: 0.1),
                        title: "Payment Methods",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _buildSectionTitle("Preferences"),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      _buildProfileMenu(
                        icon: AppIcons.notificationP,
                        iconColor: Colors.orangeAccent,
                        iconBgColor: Colors.orangeAccent.withValues(alpha: 0.1),
                        title: "Notifications",
                        trailing: Switch(
                          value: true,
                          onChanged: (val) {},
                          activeColor: AppColors.buttonGradientEnd,
                        ),
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _buildProfileMenu(
                        icon: AppIcons.passport,
                        iconColor: Colors.brown.withValues(alpha: 0.5),
                        iconBgColor: Colors.brown.withValues(alpha: 0.1),
                        title: "Change Password",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _buildSectionTitle("Support"),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: _buildProfileMenu(
                    icon: AppIcons.help,
                    iconColor: Colors.blueGrey,
                    iconBgColor: Colors.blueGrey.withValues(alpha: 0.1),
                    title: "Help & Support",
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20.sp),
                      SizedBox(width: 8.w),
                      CommonText(
                        text: "Log Out",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu({
    required String icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? trailingText,
    Color? trailingTextColor,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ProfileMenuItem(
      iconPath: icon,
      iconColor: iconColor,
      iconBgColor: iconBgColor,
      title: title,
      trailingText: trailingText,
      trailingTextColor: trailingTextColor,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          CommonText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: label,
            fontSize: 12,
            color: AppColors.textSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CommonText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }
}
