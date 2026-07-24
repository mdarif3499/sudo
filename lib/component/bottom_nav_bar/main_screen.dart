import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sudo/discoverd/screen/discover_screen.dart';
import 'bottom_nav_controller.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../text/common_text.dart';
import '../../profile/screen/profile_screen.dart';
import '../../home/screen/dashboard_screen.dart';
import '../../groups/view/groups_screen.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> screens = [
    const DashboardScreen(),
    const GroupsScreen(),
    const DiscoverScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBg : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
            border: isDark ? Border(top: BorderSide(color: AppColors.darkCardBorder, width: 0.5)) : Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5)),
          ),
          child: SafeArea(
            top: false,
            child: Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, AppString.dashboard.tr, AppIcons.homeA, AppIcons.homeI),
                  _buildNavItem(
                    context,
                    1,
                    AppString.groups.tr,
                    AppIcons.groupsA,
                    AppIcons.groupsI,
                  ),
                  _buildNavItem(
                    context,
                    2,
                    AppString.discover.tr,
                    AppIcons.discoverA,
                    AppIcons.discoverI,
                  ),
                  _buildNavItem(
                    context,
                    3,
                    AppString.profile.tr,
                    AppIcons.profileA,
                    AppIcons.profileI,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    String label,
    String activeIcon,
    String inactiveIcon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            color: isSelected ? const Color(0xFF48C8FC) : (isDark ? Colors.white60 : null),
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: label,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected
                ? const Color(0xFF48C8FC)
                : (isDark ? Colors.white38 : AppColors.textSecondaryColor7C7C7C),
          ),
        ],
      ),
    );
  }
}
