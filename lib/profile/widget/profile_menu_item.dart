import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';
import '../../component/text/common_text.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool dived;
  final String? trailingText;
  final Color? trailingTextColor;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBgColor;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.trailingText,
    this.trailingTextColor,
    this.trailing,
    required this.onTap,
    required this.iconColor,
    required this.iconBgColor,
    this.dived = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    iconPath,
                    color: iconColor,
                    height: 24.sp,
                    width: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                // Title
                Expanded(
                  child: CommonText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimaryColor,
                  ),
                ),

                // Trailing Section
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (trailingText != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CommonText(
                          text: trailingText!,
                          fontSize: 10,
                          color: trailingTextColor ?? AppColors.textSecondaryColor,
                        ),
                      ),
                    trailing ?? Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (dived) Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}