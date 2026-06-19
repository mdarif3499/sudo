import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'bottom_nav_controller.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';
import '../../profile/screen/profile_screen.dart';
import '../../home/screen/dashboard_screen.dart';
import '../../groups/view/groups_screen.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> screens = [
    const DashboardScreen(),
     GroupsScreen(),
    const Center(child: CommonText(text: "Discover Screen")),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, "Dashboard", AppIcons.homeA, AppIcons.homeI),
                  _buildNavItem(1, "Groups", AppIcons.groupsA, AppIcons.groupsI),
                  _buildNavItem(2, "Discover", AppIcons.discoverA, AppIcons.discoverI),
                  _buildNavItem(3, "Profile", AppIcons.profileA, AppIcons.profileI),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String activeIcon, String inactiveIcon) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected ? activeIcon : inactiveIcon,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: label,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected ? AppColors.buttonGradientEnd : AppColors.textSecondaryColor7C7C7C,
          ),
        ],
      ),
    );
  }
}
