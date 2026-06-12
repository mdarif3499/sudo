import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/text/common_text.dart';
import '../../utils/constants/app_colors.dart';
import '../controller/profile_controller.dart';
import '../widget/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.indicatorActive.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications_none, color: AppColors.buttonGradientEnd, size: 24.sp),
                  ),
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
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_note, color: Colors.white, size: 18.sp),
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
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person_outline,
                      iconColor: Colors.blue,
                      iconBgColor: Colors.blue.withOpacity(0.1),
                      title: "Edit Profile",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ProfileMenuItem(
                      icon: Icons.verified_user_outlined,
                      iconColor: Colors.green,
                      iconBgColor: Colors.green.withOpacity(0.1),
                      title: "KYC Verification",
                      trailingText: "Required",
                      trailingTextColor: Colors.orange,
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ProfileMenuItem(
                      icon: Icons.workspace_premium_outlined,
                      iconColor: Colors.orange,
                      iconBgColor: Colors.orange.withOpacity(0.1),
                      title: "Subscriptions",
                      trailingText: "Free",
                      trailingTextColor: Colors.orange,
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ProfileMenuItem(
                      icon: Icons.payment_outlined,
                      iconColor: Colors.purple,
                      iconBgColor: Colors.purple.withOpacity(0.1),
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
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.notifications_none,
                      iconColor: Colors.orangeAccent,
                      iconBgColor: Colors.orangeAccent.withOpacity(0.1),
                      title: "Notifications",
                      trailing: Switch(
                        value: true,
                        onChanged: (val) {},
                        activeColor: AppColors.buttonGradientEnd,
                      ),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ProfileMenuItem(
                      icon: Icons.lock_outline,
                      iconColor: Colors.brown.withOpacity(0.5),
                      iconBgColor: Colors.brown.withOpacity(0.1),
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
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: ProfileMenuItem(
                  icon: Icons.help_outline,
                  iconColor: Colors.blueGrey,
                  iconBgColor: Colors.blueGrey.withOpacity(0.1),
                  title: "Help & Support",
                  onTap: () {},
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
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
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
